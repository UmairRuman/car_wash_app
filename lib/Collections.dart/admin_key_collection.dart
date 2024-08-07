import 'dart:developer';

import 'package:bcrypt/bcrypt.dart';
import 'package:car_wash_app/ModelClasses/admin_key.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminKeyCollection {
  static final AdminKeyCollection instance = AdminKeyCollection._internal();

  AdminKeyCollection._internal();

  factory AdminKeyCollection() {
    return instance;
  }

  static final adminKeyCollection =
      FirebaseFirestore.instance.collection("Admin Configurations");

  Future<bool> addAdminKey(AdminKey adminKey) async {
    try {
      String hashedPin = BCrypt.hashpw(adminKey.pin, BCrypt.gensalt());
      adminKey.pin =
          hashedPin; // Ensure to update the pin with the hashed value
      await adminKeyCollection.doc("serviceProviderPin").set(adminKey.toMap());
      log("Admin Key added successfully");
      return true;
    } catch (e) {
      log("Error in adding admin key: $e");
      return false;
    }
  }

  Future<AdminKey> getAdminKey() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await adminKeyCollection.doc("serviceProviderPin").get();
      if (querySnapshot.exists && querySnapshot.data() != null) {
        log("Got Admin Key");
        return AdminKey.fromMap(querySnapshot.data()!);
      } else {
        log("Admin Key document does not exist or is null");
        return AdminKey(pin: "");
      }
    } catch (e) {
      log("Error in fetching admin Key: $e");
      return AdminKey(pin: "");
    }
  }
}
