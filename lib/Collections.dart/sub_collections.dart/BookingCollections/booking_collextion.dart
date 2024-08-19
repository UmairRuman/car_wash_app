import 'dart:developer';

import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/bookings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingCollection {
  static final BookingCollection instance = BookingCollection._internal();
  BookingCollection._internal();
  factory BookingCollection() {
    return instance;
  }
  static const bookingCollection = "Booking Collection";

  Future<bool> addBooking(Bookings bookings) async {
    try {
      await UserCollection.userCollection
          .doc(bookings.userId)
          .collection(bookingCollection)
          .doc(bookings.userBookingId.toString())
          .set(bookings.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBooking(Bookings bookings) async {
    try {
      await UserCollection.userCollection
          .doc(bookings.userId)
          .collection(bookingCollection)
          .doc(bookings.userBookingId.toString())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBooking(Bookings bookings) async {
    try {
      await UserCollection.userCollection
          .doc(bookings.userId)
          .collection(bookingCollection)
          .doc(bookings.userBookingId.toString())
          .update(bookings.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteOldBookings(String userId) async {
    try {
      final now = DateTime.now();
      final cutoff = now.subtract(const Duration(hours: 48));

      var query = await UserCollection.userCollection
          .doc(userId)
          .collection(BookingCollection.bookingCollection)
          .where('bookingDate', isLessThanOrEqualTo: Timestamp.fromDate(cutoff))
          .get();

      for (var doc in query.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      log("Error deleting old bookings: $e");
    }
  }

  Future<List<Bookings>> getAllBookings(String userId) async {
    try {
      var querrySnapshot = await UserCollection.userCollection
          .doc(userId)
          .collection(bookingCollection)
          .get();
      if (querrySnapshot.docs.isNotEmpty) {
        return querrySnapshot.docs
            .map(
              (doc) => Bookings.fromMap(doc.data()),
            )
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
