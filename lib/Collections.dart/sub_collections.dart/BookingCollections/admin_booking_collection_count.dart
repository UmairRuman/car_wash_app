import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_booking_counter.dart';

class AdminBookingCollectionCount {
  static final AdminBookingCollectionCount instance =
      AdminBookingCollectionCount._internal();
  AdminBookingCollectionCount._internal();
  factory AdminBookingCollectionCount() {
    return instance;
  }
  static const String adminBookingCountCollection =
      "Admin Booking Count Collection";

  Future<bool> addAdminBookingCount(
      FavouriteServicesCounter userBookingCounter) async {
    try {
      UserCollection.userCollection
          .doc(userBookingCounter.userId)
          .collection(AdminBookingCollectionCount.adminBookingCountCollection)
          .doc(userBookingCounter.count.toString())
          .set(userBookingCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAdminBookingCount(
      FavouriteServicesCounter userBookingCounter) async {
    try {
      UserCollection.userCollection
          .doc(userBookingCounter.userId)
          .collection(AdminBookingCollectionCount.adminBookingCountCollection)
          .doc(userBookingCounter.count.toString())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatingAdminBookCount(
      FavouriteServicesCounter userBookingCounter) async {
    try {
      UserCollection.userCollection
          .doc(userBookingCounter.userId)
          .collection(AdminBookingCollectionCount.adminBookingCountCollection)
          .doc(userBookingCounter.count.toString())
          .update(userBookingCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<FavouriteServicesCounter>> getAllUserBookingsCount(
      String adminId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(adminId)
          .collection(AdminBookingCollectionCount.adminBookingCountCollection)
          .get();
      return querrySnapshots.docs
          .map(
            (doc) => FavouriteServicesCounter.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
