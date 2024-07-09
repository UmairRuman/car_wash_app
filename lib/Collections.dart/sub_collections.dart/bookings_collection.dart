import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/bookings.dart';

class BookingCollection {
  static final BookingCollection instance = BookingCollection._internal();
  BookingCollection._internal();
  factory BookingCollection() {
    return instance;
  }
  static const bookingCollection = "Booking Collection";

  Future<bool> addBooking(String userId, Bookings bookings) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(bookingCollection)
          .doc(bookings.bookingId)
          .set(bookings.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBooking(String userId, Bookings bookings) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(bookingCollection)
          .doc(bookings.bookingId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBooking(String userId, Bookings bookings) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(bookingCollection)
          .doc(bookings.bookingId)
          .update(bookings.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Bookings>> getAllBookings(String userId) async {
    try {
      var querrySnapshot = await UserCollection.userCollection
          .doc(userId)
          .collection(bookingCollection)
          .get();
      return querrySnapshot.docs
          .map(
            (doc) => Bookings.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
