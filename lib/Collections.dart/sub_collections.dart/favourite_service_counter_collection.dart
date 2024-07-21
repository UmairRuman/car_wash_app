import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_booking_counter.dart';

class FavouriteServicesCounterCollection {
  static final FavouriteServicesCounterCollection instance =
      FavouriteServicesCounterCollection._internal();
  FavouriteServicesCounterCollection._internal();
  factory FavouriteServicesCounterCollection() {
    return instance;
  }
  static const String adminBookingCountCollection =
      "Favourite Service Count Collection";

  Future<bool> addAdminBookingCount(
      AdminServiceCounter favouriteServiceCounter) async {
    try {
      UserCollection.userCollection
          .doc(favouriteServiceCounter.userId)
          .collection(
              FavouriteServicesCounterCollection.adminBookingCountCollection)
          .doc(favouriteServiceCounter.count.toString())
          .set(favouriteServiceCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAdminBookingCount(
      AdminServiceCounter favouriteServiceCounter) async {
    try {
      UserCollection.userCollection
          .doc(favouriteServiceCounter.userId)
          .collection(
              FavouriteServicesCounterCollection.adminBookingCountCollection)
          .doc(favouriteServiceCounter.count.toString())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatingAdminBookCount(
      AdminServiceCounter favouriteServiceCounter) async {
    try {
      UserCollection.userCollection
          .doc(favouriteServiceCounter.userId)
          .collection(
              FavouriteServicesCounterCollection.adminBookingCountCollection)
          .doc(favouriteServiceCounter.count.toString())
          .update(favouriteServiceCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<AdminServiceCounter>> getAllUserBookingsCount(
      String userId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(
              FavouriteServicesCounterCollection.adminBookingCountCollection)
          .get();
      return querrySnapshots.docs
          .map(
            (doc) => AdminServiceCounter.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
