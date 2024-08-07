import 'package:car_wash_app/ModelClasses/admin_count.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCountCollection {
  static final AdminCountCollection instance = AdminCountCollection._internal();
  AdminCountCollection._internal();
  static final adminCounterCollection =
      FirebaseFirestore.instance.collection("Admin Counter Collection");
  factory AdminCountCollection() {
    return instance;
  }
  Future<bool> increamentAdminAdd(AdminCounter adminCounter) async {
    try {
      await AdminCountCollection.adminCounterCollection
          .doc(adminCounter.count)
          .set(adminCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAdminCount(AdminCounter adminCounter) async {
    try {
      await AdminCountCollection.adminCounterCollection
          .doc(adminCounter.count)
          .update(adminCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAdminCount(AdminCounter adminCounter) async {
    try {
      await AdminCountCollection.adminCounterCollection
          .doc(adminCounter.count)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<AdminCounter>> getAllAdminCount() async {
    try {
      var querrySnapShot =
          await AdminCountCollection.adminCounterCollection.get();

      return querrySnapShot.docs
          .map(
            (doc) => AdminCounter.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
