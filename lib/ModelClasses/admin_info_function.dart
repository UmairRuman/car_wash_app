import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String adminInfoKey = "AdminId";

Future<void> initializeAdminInfo(WidgetRef ref, SharedPreferences prefs) async {
  final adminInfoController = ref.read(adminInfoProvider.notifier);
  String? storedAdminInfo = prefs.getString(adminInfoKey);

  if (storedAdminInfo == null) {
    try {
      // Fetch the admin info from Firestore
      String adminId = FirebaseAuth.instance.currentUser!.uid;
      await adminInfoController.setAdminInfo(
        adminId: adminId,
        adminName: "Umair Ruman",
        adminNo: 1,
      );

      // Save the admin info in shared preferences
      String adminInfoJson = await adminInfoController.getAdminInfo();
      prefs.setString(adminInfoKey, adminInfoJson);
    } catch (e) {
      log('Failed to initialize admin info: $e');
    }
  } else {
    adminInfoController.setStoredAdminInfo(storedAdminInfo);
  }
}
