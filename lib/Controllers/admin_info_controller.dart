import 'dart:convert';
import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminInfoController extends Notifier<AdminInfo> {
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  bool isInfoGet = false;

  @override
  AdminInfo build() {
    return AdminInfo(
        adminName: "",
        adminId: "",
        adminNo: "",
        adminPhoneNo: "",
        adminDeviceToken: "");
  }

  Future<void> setAdminInfo(
      {required String adminId,
      required String adminName,
      required String adminNo,
      required String adminDeviceToken,
      required String adminPhoneNo}) async {
    AdminInfo adminInfo = AdminInfo(
      adminDeviceToken: adminDeviceToken,
      adminPhoneNo: adminPhoneNo,
      adminName: adminName,
      adminId: adminId,
      adminNo: adminNo,
    );
    await adminInfoCollection.insertAdminInfo(adminInfo);
    state = adminInfo;
  }

  Future<AdminInfo> getAdminInfoWithId(int id) async {
    var adminData;
    try {
      log("adding adminInfo");
      adminData = await getAdminInfoWithId(id);
    } catch (e) {
      log("Eror in fetcching admin info :$e");
    }
    return AdminInfo(
        adminDeviceToken: adminData.adminDeviceToken,
        adminName: adminData.adminName,
        adminId: adminData.adminId,
        adminNo: adminData.adminNo,
        adminPhoneNo: adminData.adminPhoneNo);
  }

  Future<String> getAdminsInfo() async {
    var adminInfoList = await adminInfoCollection.getAdminId();
    if (adminInfoList.isNotEmpty) {
      state = adminInfoList[0];
      return jsonEncode(state.toMap());
    } else {
      throw Exception('No admin info found');
    }
  }

  void setStoredAdminInfo(
      String adminId, String adminPhoneNo, String adminDeviceToken) {
    state = AdminInfo(
      adminDeviceToken: adminDeviceToken,
      adminId: adminId,
      adminPhoneNo: adminPhoneNo,
      adminName: "Umair Ruman", // Use the stored admin name if needed
      adminNo: "01", // Use the stored admin number if needed
    );
  }
}

final adminInfoProvider =
    NotifierProvider<AdminInfoController, AdminInfo>(AdminInfoController.new);
