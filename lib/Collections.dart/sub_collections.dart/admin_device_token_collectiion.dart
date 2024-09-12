import 'package:car_wash_app/ModelClasses/admin_device_token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDeviceTokenCollection {
  static final AdminDeviceTokenCollection instance =
      AdminDeviceTokenCollection._internal();

  AdminDeviceTokenCollection._internal();
  static final adminDeviceTokenCollection =
      FirebaseFirestore.instance.collection("Admin Token Collection");
  factory AdminDeviceTokenCollection() {
    return instance;
  }

  Future<bool> addAdminDeviceToken(AdminDeviceTokens deviceTokens) async {
    try {
      await AdminDeviceTokenCollection.adminDeviceTokenCollection
          .doc(deviceTokens.adminId)
          .set(deviceTokens.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAdminDeviceToken(String token, String adminId) async {
    try {
      await AdminDeviceTokenCollection.adminDeviceTokenCollection
          .doc(adminId)
          .update({"deviceToken": token});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateSpecificField(String userId, String deviceToken) async {
    try {
      await AdminDeviceTokenCollection.adminDeviceTokenCollection
          .doc(userId)
          .update({"deviceToken": deviceToken});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAdminDeviceToken(AdminDeviceTokens deviceTokens) async {
    try {
      await AdminDeviceTokenCollection.adminDeviceTokenCollection
          .doc(deviceTokens.adminId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AdminDeviceTokens> getSpecificDeviceToken(String adminId) async {
    try {
      var querySnapshots = await AdminDeviceTokenCollection
          .adminDeviceTokenCollection
          .doc(adminId)
          .get();
      return AdminDeviceTokens.fromMap(querySnapshots.data()!);
    } catch (e) {
      return AdminDeviceTokens(deviceToken: "", adminNo: "", adminId: "");
    }
  }

  Future<List<AdminDeviceTokens>> getAllAdminDeviceTokens() async {
    try {
      var querySnapshots =
          await AdminDeviceTokenCollection.adminDeviceTokenCollection.get();

      return querySnapshots.docs
          .map((doc) => AdminDeviceTokens.fromMap(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
