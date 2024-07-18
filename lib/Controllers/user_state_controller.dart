import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/Users.dart';
import 'package:car_wash_app/ModelClasses/admin_info.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userAdditionStateProvider =
    NotifierProvider<UserStateNotifier, UserAdditionStates>(
        UserStateNotifier.new);

class UserStateNotifier extends Notifier<UserAdditionStates> {
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
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

  void addUser() async {
    log("User name ${listOfUserInfo[MapForUserInfo.userName]}");
    log("User id ${listOfUserInfo[MapForUserInfo.userId]}");
    log("User gmail ${listOfUserInfo[MapForUserInfo.email]}");
    log("Profile Pic Url ${listOfUserInfo[MapForUserInfo.profilePicUrl]}");
    log("Is Service Provider ${listOfUserInfo[MapForUserInfo.isServiceProvider]}");
    log("User Location ${listOfUserInfo[MapForUserInfo.userLocation]}");
    log("Phone No ${listOfUserInfo[MapForUserInfo.phoneNumber]}");

    if (listOfUserInfo[MapForUserInfo.userId] != "" &&
        listOfUserInfo[MapForUserInfo.userName] != "") {
      var userName = listOfUserInfo[MapForUserInfo.userName];
      var userId = listOfUserInfo[MapForUserInfo.userId];
      var userPhoneNo = listOfUserInfo[MapForUserInfo.phoneNumber];

      if (listOfUserInfo[MapForUserInfo.isServiceProvider]) {
        adminInfoCollection.insertAdminInfo(AdminInfo(
            adminName: userName,
            adminId: userId,
            adminNo: 1,
            adminPhoneNo: userPhoneNo));
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool(ShraedPreferncesConstants.isServiceProvider,
          listOfUserInfo[MapForUserInfo.isServiceProvider]);
      sharedPreferences.setString(ShraedPreferncesConstants.phoneNo,
          listOfUserInfo[MapForUserInfo.phoneNumber]);
      log("All data added");
      isUserDataAdded = true;
      bool isUserAdd = await userCollection.addUser(Users(
          userId: userId,
          name: userName,
          email: listOfUserInfo[MapForUserInfo.email],
          profilePicUrl: listOfUserInfo[MapForUserInfo.profilePicUrl],
          phoneNumber: userPhoneNo,
          isServiceProvider: listOfUserInfo[MapForUserInfo.isServiceProvider],
          bonusPoints: listOfUserInfo[MapForUserInfo.bonusPoints],
          serviceConsumed: listOfUserInfo[MapForUserInfo.serviceConsumed],
          createdAt: listOfUserInfo[MapForUserInfo.createdAt],
          userLocation: listOfUserInfo[MapForUserInfo.userLocation]));
      log("User  added $isUserAdd");
    }
  }

  void getUser(String userId) async {
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
