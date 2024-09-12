import 'package:car_wash_app/ModelClasses/admin_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminInfoCollection {
  static final AdminInfoCollection instance = AdminInfoCollection._internal();
  AdminInfoCollection._internal();
  static final adminInfoCollection =
      FirebaseFirestore.instance.collection("Admin Info Collection");
  factory AdminInfoCollection() {
    return instance;
  }

  Future<bool> insertAdminInfo(AdminInfo adminInfo) async {
    try {
      await adminInfoCollection.doc(adminInfo.adminId).set(adminInfo.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAdminDeviceToken(
      String adminId, String adminDeviceToken) async {
    try {
      await adminInfoCollection
          .doc(adminId)
          .update({"adminDeviceToken": adminDeviceToken});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AdminInfo> getAdminInfoByNumber(String adminNo) async {
    try {
      var querySnapshot =
          await adminInfoCollection.where("adminNo", isEqualTo: adminNo).get();
      if (querySnapshot.docs.isNotEmpty) {
        return AdminInfo.fromMap(querySnapshot.docs.first.data());
      } else {
        // Return an empty AdminInfo object if no matching admin is found
        return AdminInfo(
          adminDeviceToken: "",
          adminName: "",
          adminId: "",
          adminNo: "",
          adminPhoneNo: "",
        );
      }
    } catch (e) {
      // Handle any errors that occur during the query
      return AdminInfo(
        adminDeviceToken: "",
        adminName: "",
        adminId: "",
        adminNo: "",
        adminPhoneNo: "",
      );
    }
  }

  Future<List<AdminInfo>> getAllAdminInfo() async {
    try {
      var querrySnapShot = await adminInfoCollection.get();
      return querrySnapShot.docs
          .map(
            (doc) => AdminInfo.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
