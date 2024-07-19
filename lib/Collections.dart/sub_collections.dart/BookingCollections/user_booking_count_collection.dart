import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/user_booking_counter.dart';

class UserBookingCountCollection {
  static final UserBookingCountCollection instance =
      UserBookingCountCollection._internal();
  UserBookingCountCollection._internal();

  factory UserBookingCountCollection() {
    return instance;
  }
  static const String userBookingCountCollection =
      "User Booking Count Collection";

  Future<bool> addUserBookingCount(
      UserBookingCounter userBookingCounter) async {
    try {
      UserCollection.userCollection
          .doc(userBookingCounter.userId)
          .collection(UserBookingCountCollection.userBookingCountCollection)
          .doc(userBookingCounter.count.toString())
          .set(userBookingCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUserBookingCount(
      UserBookingCounter userBookingCounter) async {
    try {
      UserCollection.userCollection
          .doc(userBookingCounter.userId)
          .collection(UserBookingCountCollection.userBookingCountCollection)
          .doc(userBookingCounter.count.toString())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateingUserBookCount(
      UserBookingCounter userBookingCounter) async {
    try {
      UserCollection.userCollection
          .doc(userBookingCounter.userId)
          .collection(UserBookingCountCollection.userBookingCountCollection)
          .doc(userBookingCounter.count.toString())
          .update(userBookingCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<UserBookingCounter>> getAllUserBookingsCount(
      String userId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(UserBookingCountCollection.userBookingCountCollection)
          .get();
      return querrySnapshots.docs
          .map(
            (doc) => UserBookingCounter.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
