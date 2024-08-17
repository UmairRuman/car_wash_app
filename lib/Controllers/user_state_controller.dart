import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_count_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Functions/admin_info_function.dart';
import 'package:car_wash_app/ModelClasses/Users.dart';
import 'package:car_wash_app/ModelClasses/admin_count.dart';
import 'package:car_wash_app/ModelClasses/admin_device_token.dart';
import 'package:car_wash_app/ModelClasses/admin_info.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/firebase_notifications/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userAdditionStateProvider =
    NotifierProvider<UserStateNotifier, UserAdditionStates>(
        UserStateNotifier.new);

class UserStateNotifier extends Notifier<UserAdditionStates> {
  NotificationServices notificationServices = NotificationServices();
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  AdminCountCollection adminCountCollection = AdminCountCollection();

  AdminDeviceTokenCollection adminDeviceTokenCollection =
      AdminDeviceTokenCollection();
  String phoneNumberForLogin = "";
  Future<String>? deviceToken;
  Map<String, dynamic> listOfUserInfo = {
    MapForUserInfo.userName: "",
    MapForUserInfo.email: "",
    MapForUserInfo.userId: "",
    MapForUserInfo.isServiceProvider: false,
    MapForUserInfo.profilePicUrl: "",
    MapForUserInfo.serviceConsumed: 0.0,
    MapForUserInfo.bonusPoints: 0.0,
    MapForUserInfo.phoneNumber: "",
    MapForUserInfo.createdAt: DateTime.now(),
    MapForUserInfo.userLocation: ""
  };
  bool isUserDataAdded = false;
  UserCollection userCollection = UserCollection();
  @override
  UserAdditionStates build() {
    return AdditionIntialState();
  }

  //Method for getting user phone number
  Future<void> getUserPhoneNumber(String userId) async {
    try {
      phoneNumberForLogin = await userCollection.getUserPhoneNumber(userId);
    } catch (e) {
      log("Error in fetching  user Phone number  ");
    }
  }

  Future<void> updateAdminToken(String deviceToken) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await adminDeviceTokenCollection.updateSpecificField(
          currentUserId, deviceToken);
    } catch (e) {
      log("Failed to update device token ");
    }
  }

  Future<void> updateUserToken(String userId, String deviceToken) async {
    try {
      await userCollection.updateUserDeviceToken(userId, deviceToken);
    } catch (e) {
      log("Failed to update device token ");
    }
  }

  void addUser() async {
    log("User name ${listOfUserInfo[MapForUserInfo.userName]}");
    log("User id ${listOfUserInfo[MapForUserInfo.userId]}");
    log("User gmail ${listOfUserInfo[MapForUserInfo.email]}");
    log("Profile Pic Url ${listOfUserInfo[MapForUserInfo.profilePicUrl]}");
    log("Is Service Provider ${listOfUserInfo[MapForUserInfo.isServiceProvider]}");
    log("User Location ${listOfUserInfo[MapForUserInfo.userLocation]}");
    log("Phone No ${FirebaseAuth.instance.currentUser!.phoneNumber!}");
    //In user collection firstly we get user device token
    var realToken = await notificationServices.getTokken();
    log("Device Token $realToken");
    //Getting admin info to add in user shared prefrences to avoid from firebase cost
    var realAdminInfo =
        await adminInfoCollection.getAdminsInfoAtSpecificId("01");
    //We have to get all admin device tokens
    var allAdminsDeviceTokenlist =
        await adminDeviceTokenCollection.getAllAdminDeviceTokens();

    var userName = listOfUserInfo[MapForUserInfo.userName] == ""
        ? FirebaseAuth.instance.currentUser!.displayName
        : listOfUserInfo[MapForUserInfo.userName];
    var userId = listOfUserInfo[MapForUserInfo.userId] == ""
        ? FirebaseAuth.instance.currentUser!.uid
        : listOfUserInfo[MapForUserInfo.userId];
    var userPhoneNo = listOfUserInfo[MapForUserInfo.phoneNumber] == ""
        ? FirebaseAuth.instance.currentUser!.phoneNumber
        : listOfUserInfo[MapForUserInfo.phoneNumber];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //If the user is admin then we will fetch the list of admin to check their number and add admin info
    var listOFAdminCount = await adminCountCollection.getAllAdminCount();
    String adminNo = "${listOFAdminCount.length + 1}";
    if (listOFAdminCount.length < 9) {
      adminNo = "0${listOFAdminCount.length + 1}";
    }
    //If the user is admin, then we add user data in collection.
    if (listOfUserInfo[MapForUserInfo.isServiceProvider]) {
      adminInfoCollection.insertAdminInfo(AdminInfo(
          adminDeviceToken: realToken,
          adminName: userName,
          adminId: userId,
          adminNo: adminNo,
          adminPhoneNo: userPhoneNo));
      //Adding device Token in Admin Device Token Collection
      await adminDeviceTokenCollection.addAdminDeviceToken(AdminDeviceTokens(
          deviceToken: realToken,
          adminNo: adminNo,
          adminId: FirebaseAuth.instance.currentUser!.uid));
      //Now we will also increment one in that Admin Count Collection
      await adminCountCollection
          .increamentAdminAdd(AdminCounter(count: adminNo));
    }
    //We also set is service provider in shared prefrences to avoid from the cost got every time for getting data from firestore
    sharedPreferences.setBool(SharedPreferncesConstants.isServiceProvider,
        listOfUserInfo[MapForUserInfo.isServiceProvider]);

    //Getting main admin data and then add to added user
    //Firstly we check if the admin is added before
    List<String> listOfTokens = [];
    for (int index = 0; index < allAdminsDeviceTokenlist.length; index++) {
      listOfTokens.add(allAdminsDeviceTokenlist[index].deviceToken);
    }

    if (realAdminInfo.adminId != "") {
      //Storing all the admin info iin shared prefrences
      storeServiceProviderTokens(listOfTokens);
      sharedPreferences.setString(
          SharedPreferncesConstants.phoneNo, realAdminInfo.adminPhoneNo);
      sharedPreferences.setString(
          SharedPreferncesConstants.adminkey, realAdminInfo.adminId);
      sharedPreferences.setInt(
          SharedPreferncesConstants.adminCount, int.parse(adminNo));
    }

    log("User Shared Prefrences");
    log("Phone number in shared prefrences ${sharedPreferences.getString(SharedPreferncesConstants.phoneNo)}");
    log("Admin Id in shared prefrences ${sharedPreferences.getString(SharedPreferncesConstants.adminkey)}");
    log("Admin Device Token in shared prefrences ${sharedPreferences.getString(SharedPreferncesConstants.adminTokenKey)}");

    log("All data added");
    isUserDataAdded = true;
    bool isUserAdd = await userCollection.addUser(Users(
        deviceToken: realToken,
        userId: userId,
        name: userName,
        email: listOfUserInfo[MapForUserInfo.email] ?? "",
        profilePicUrl: listOfUserInfo[MapForUserInfo.profilePicUrl],
        phoneNumber: userPhoneNo,
        isServiceProvider: listOfUserInfo[MapForUserInfo.isServiceProvider],
        bonusPoints: listOfUserInfo[MapForUserInfo.bonusPoints],
        serviceConsumed: listOfUserInfo[MapForUserInfo.serviceConsumed],
        createdAt: DateTime.now(),
        userLocation: listOfUserInfo[MapForUserInfo.userLocation]));
    log("User  added $isUserAdd");
  }

  Future<void> getUser(String userId) async {
    await Future.delayed(const Duration(seconds: 3));
    state = AdditionLoadingState();

    try {
      var user = await userCollection.getUser(userId);
      state = AddittionLoadedState(user: user);
    } catch (e) {
      state = AdditionErrorState(error: e.toString());
    }
  }
}

abstract class UserAdditionStates {}

class AdditionIntialState extends UserAdditionStates {}

class AdditionLoadingState extends UserAdditionStates {}

class AddittionLoadedState extends UserAdditionStates {
  final Users user;
  AddittionLoadedState({required this.user});
}

class AdditionErrorState extends UserAdditionStates {
  final String error;
  AdditionErrorState({required this.error});
}
