import 'dart:convert';
import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminInfoController extends Notifier<AdminInfo> {
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  bool isInfoGet = false;

  @override
  AdminInfo build() {
    return AdminInfo(adminName: "", adminId: "", adminNo: 0);
  }

  Future<void> setAdminInfo({
    required String adminId,
    required String adminName,
    required int adminNo,
  }) async {
    AdminInfo adminInfo = AdminInfo(
      adminName: adminName,
      adminId: adminId,
      adminNo: adminNo,
    );
    await adminInfoCollection.insertAdminId(adminInfo);
    state = adminInfo;
  }

  Future<String> getAdminInfo() async {
    var adminInfoList = await adminInfoCollection.getAdminId();
    if (adminInfoList.isNotEmpty) {
      state = adminInfoList[0];
      return jsonEncode(state.toMap());
    } else {
      throw Exception('No admin info found');
    }
  }

  void setStoredAdminInfo(String adminInfoJson) {
    Map<String, dynamic> adminInfoMap = jsonDecode(adminInfoJson);
    state = AdminInfo.fromMap(adminInfoMap);
  }
}

final adminInfoProvider =
    NotifierProvider<AdminInfoController, AdminInfo>(AdminInfoController.new);
