import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
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

Future<void> removeAdminIdFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(SharedPreferncesConstants.adminkey);
  await prefs.remove(SharedPreferncesConstants.phoneNo);
  await prefs.remove(SharedPreferncesConstants.isServiceProvider);
}

Future<void> getAdminIdFromFireStore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  var adminInfo = await adminInfoCollection.getAdminsInfoAtSpecificId(1);
  log("(Admin ID ) : ${adminInfo.adminId} ");

  if (adminInfo.adminNo >= 1) {
    String? storedAdminId = prefs.getString(SharedPreferncesConstants.adminkey);
    log("In Admin Info function");
    if (storedAdminId == null) {
      prefs.setString(SharedPreferncesConstants.adminkey, adminInfo.adminId);
      prefs.setString(
          SharedPreferncesConstants.adminTokenKey, adminInfo.adminDeviceToken);
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
