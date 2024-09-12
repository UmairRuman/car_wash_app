import 'dart:developer';

import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/bookings.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final adminId = prefs.getString(SharedPreferncesConstants.adminkey) == ""
          ? FirebaseAuth.instance.currentUser!.uid
          : prefs.getString(SharedPreferncesConstants.adminkey);
      log("Admin Id in delete Old bookings method $adminId");
      final isServiceProvider =
          prefs.getBool(SharedPreferncesConstants.isServiceProvider);
      int hours = 168; // Default to 1 week (168 hours) for the admin
      log("Is service provider in delete old bookings $isServiceProvider");

      // If the user is a client
      if (currentUserId != adminId &&
          isServiceProvider != null &&
          !isServiceProvider) {
        var allBookings = await getAllBookings(currentUserId);

        // Ensure there are bookings to process
        if (allBookings.isNotEmpty) {
          final clientCutoff =
              allBookings.last.carWashdate.add(const Duration(hours: 24));

          // Ensure the cutoff is not in the future to avoid negative hours
          if (clientCutoff.isBefore(DateTime.now())) {
            hours = DateTime.now().difference(clientCutoff).inHours;
          } else {
            // If cutoff is in the future, set hours to 0 to avoid deletion
            hours = 0;
          }
        }
      }

      log("In delete Old Bookings");
      log("Hours $hours");
      final now = DateTime.now();
      final cutoff = now.subtract(Duration(hours: hours));

      var query = await UserCollection.userCollection
          .doc(userId)
          .collection(BookingCollection.bookingCollection)
          .where('carWashdate', isLessThanOrEqualTo: Timestamp.fromDate(cutoff))
          .get();

      for (var doc in query.docs) {
        log("Booking to delete ${doc.data()}");
        log("Path of Documnet  ${doc.reference}");
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
          .orderBy("bookingDate", descending: false)
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
      log("Exception at deleting bookings ${e.toString()}");
      return [];
    }
  }
}
