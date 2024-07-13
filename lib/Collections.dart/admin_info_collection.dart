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

  Future<bool> insertAdminId(AdminInfo adminInfo) async {
    try {
      await adminInfoCollection
          .doc(adminInfo.adminNo.toString())
          .set(adminInfo.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<AdminInfo>> getAdminId() async {
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
