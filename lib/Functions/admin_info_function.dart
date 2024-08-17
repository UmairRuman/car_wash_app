import 'dart:convert';
import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_count_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String adminInfoKey = "adminId";
const String adminPhoneKey = "adminPhoneNo";
Future<String?> getAdminIdFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(adminInfoKey);
}

Future<String?> getAdminPhoneNoFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(SharedPreferncesConstants.phoneNo);
}

Future<bool?> findIfServiceProvider() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(SharedPreferncesConstants.isServiceProvider);
}

//Function For removing Admin data from
Future<void> removeAdminIdFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(SharedPreferncesConstants.adminkey);
  await prefs.remove(SharedPreferncesConstants.phoneNo);
  await prefs.remove(SharedPreferncesConstants.isServiceProvider);
  await prefs.remove(SharedPreferncesConstants.adminTokenKey);
}

void storeServiceProviderTokens(List<String> tokens) {
  log(tokens.toString());
  String tokensJson = jsonEncode(tokens);
  prefs!.setString(SharedPreferncesConstants.adminTokenKey, tokensJson);
}

Future<void> getAdminIdFromFireStore(WidgetRef ref) async {
  UserCollection userCollection = UserCollection();
  AdminCountCollection adminCountCollection = AdminCountCollection();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  AdminDeviceTokenCollection adminDeviceTokenCollection =
      AdminDeviceTokenCollection();
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  var adminCount = await adminCountCollection.getAllAdminCount();
  var adminInfo = await adminInfoCollection.getAdminsInfoAtSpecificId("01");
  var list = await adminDeviceTokenCollection.getAllAdminDeviceTokens();

  int? adminCountInSharedPrefrences =
      prefs.getInt(SharedPreferncesConstants.adminCount);
  String? adminIdInSharedPrefrences =
      prefs.getString(SharedPreferncesConstants.adminkey);
  log("(Admin ID ) : ${adminInfo.adminId} ");

  if (FirebaseAuth.instance.currentUser != null) {
    var isUserServiceProvider = await userCollection
        .getUserInfo(FirebaseAuth.instance.currentUser!.uid);
    prefs.setBool(
        SharedPreferncesConstants.isServiceProvider, isUserServiceProvider);
    if (adminIdInSharedPrefrences == null ||
        adminCountInSharedPrefrences == null ||
        adminCountInSharedPrefrences != adminCount.length) {
      log("In Admin Info function");

      List<String> listOfTokens = [];
      for (int index = 0; index < list.length; index++) {
        listOfTokens.add(list[index].deviceToken);
      }
      storeServiceProviderTokens(listOfTokens);
      // ref.read(realAdminStateProvider.notifier).isRealAdmin();
      prefs.setString(SharedPreferncesConstants.adminkey, adminInfo.adminId);
      prefs.setString(
          SharedPreferncesConstants.phoneNo, adminInfo.adminPhoneNo);
      prefs.setInt(SharedPreferncesConstants.adminCount, list.length);
    }
  }
}

List<String> getServiceProviderTokens() {
  String? tokensJson =
      prefs!.getString(SharedPreferncesConstants.adminTokenKey);

  if (tokensJson != null) {
    List<dynamic> decodedJson = jsonDecode(tokensJson);
    return decodedJson.cast<String>();
  } else {
    return [];
  }
}
