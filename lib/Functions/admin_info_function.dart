import 'dart:convert';
import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Controllers/real_admin_state.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
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
  String tokensJson = jsonEncode(tokens);
  prefs!.setString(SharedPreferncesConstants.adminTokenKey, tokensJson);
}

Future<void> getAdminIdFromFireStore(WidgetRef ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  AdminDeviceTokenCollection adminDeviceTokenCollection =
      AdminDeviceTokenCollection();
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  var adminInfo = await adminInfoCollection.getAdminsInfoAtSpecificId("01");
  var list = await adminDeviceTokenCollection.getAllAdminDeviceTokens();
  log("(Admin ID ) : ${adminInfo.adminId} ");

  if (adminInfo.adminNo != "") {
    String? storedAdminId = prefs.getString(SharedPreferncesConstants.adminkey);
    String? storedAdminPhone =
        prefs.getString(SharedPreferncesConstants.phoneNo);
    int? adminCount = prefs.getInt(SharedPreferncesConstants.adminCount);
    log("In Admin Info function");
    if (storedAdminId == null ||
        storedAdminPhone == null ||
        adminCount != list.length) {
      List<String> listOfTokens = [];
      for (int index = 0; index < list.length; index++) {
        listOfTokens.add(list[index].deviceToken);
      }
      storeServiceProviderTokens(listOfTokens);
      log("Admin info ${adminInfo.adminId}");
      log("Admin info phone n0 ${adminInfo.adminPhoneNo}");
      ref.read(realAdminStateProvider.notifier).isRealAdmin();
      prefs.setString(SharedPreferncesConstants.adminkey, adminInfo.adminId);
      prefs.setString(
          SharedPreferncesConstants.phoneNo, adminInfo.adminPhoneNo);
      prefs.setInt(SharedPreferncesConstants.adminCount, list.length);
    }
  } else {
    removeAdminIdFromPrefs();
  }
}

// Future<void> initializeAdminInfo(WidgetRef ref, SharedPreferences prefs) async {
//   final adminInfoController = ref.read(adminInfoProvider.notifier);
//   var adminInfo =
//       await ref.read(adminInfoProvider.notifier).getAdminInfoWithId(1);
//   String? storedAdminId = prefs.getString(adminInfoKey);
//   String? storedAdminPhoneNo = prefs.getString(adminPhoneKey);
//   log("Admin id : ${adminInfo.adminId}");

//   if (storedAdminId == null || storedAdminPhoneNo == null) {
//     try {
//       // Fetch the admin info from Firestore
//       String adminId = adminInfo.adminId;
//       String adminPhoneNo = adminInfo.adminPhoneNo;
//       log("Admin Id  : $adminId");
//       log("Admin Phone Number  : $adminPhoneNo");
//       await adminInfoController.setAdminInfo(
//         adminPhoneNo: adminPhoneNo,
//         adminId: adminId,
//         adminName: "Umair Ruman",
//         adminNo: 1,
//       );

//       prefs.setString(adminInfoKey, adminId);
//       prefs.setString(adminPhoneKey, adminPhoneNo);
//     } catch (e) {
//       log('Failed to initialize admin info: $e');
//     }
//   } else {
//     adminInfoController.setStoredAdminInfo(
//       storedAdminId,
//       storedAdminPhoneNo,
//     );
//   }
// }
