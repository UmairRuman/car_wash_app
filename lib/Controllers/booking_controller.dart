import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/admin_booking_collection_count.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/user_booking_count_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_booking_counter.dart';
import 'package:car_wash_app/ModelClasses/bookings.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/ModelClasses/user_booking_counter.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingStateProvider =
    NotifierProvider<BookingController, BookingStates>(BookingController.new);

class BookingController extends Notifier<BookingStates> {
  var adminId = prefs!.getString(SharedPreferncesConstants.adminkey);
  String? carType;
  DateTime? carWashDate;
  String? carPrice;
  String? timeSlot;
  bool? isCarAssetImage;
  String? carImagePath;
  BookingCollection bookingCollection = BookingCollection();
  AdminBookingCollectionCount adminBookingCollectionCount =
      AdminBookingCollectionCount();
  UserBookingCountCollection userBookingCountCollection =
      UserBookingCountCollection();
  @override
  BookingStates build() {
    return BookingIntialState();
  }

  Future<void> addBooking(
      String serviceId, String serviceName, String serviceImageUrl) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final bookerName = FirebaseAuth.instance.currentUser!.uid;
      var adminBookingsTotalCount =
          await adminBookingCollectionCount.getAllUserBookingsCount(adminId!);
      var userBookingsTotalCount =
          await userBookingCountCollection.getAllUserBookingsCount(userId);
      String userBookingId = "${userBookingsTotalCount.length + 1}";
      String adminBookingId = "${adminBookingsTotalCount.length + 1}";
      if (userBookingsTotalCount.length < 9) {
        userBookingId = "0${userBookingsTotalCount.length + 1}";
      }
      if (adminBookingsTotalCount.length < 9) {
        adminBookingId = "0${adminBookingsTotalCount.length + 1}";
      }

      if (carWashDate != null &&
          carType != null &&
          carPrice != null &&
          timeSlot != null) {
        //Adding Booking in client Collection
        bookingCollection.addBooking(Bookings(
            bookerName: bookerName,
            userBookingId: userBookingId,
            userId: userId,
            serviceId: serviceId,
            carType: carType!,
            carWashdate: carWashDate!,
            price: carPrice!,
            bookingStatus: BookingStatus.confirmed,
            bookingDate: DateTime.now(),
            serviceImageUrl: serviceImageUrl,
            serviceName: serviceName,
            timeSlot: timeSlot!));
        //Adding booking at Admin Collection
        bookingCollection.addBooking(Bookings(
            bookerName: bookerName,
            userBookingId: adminBookingId,
            userId: userId,
            serviceId: serviceId.toString(),
            carType: carType!,
            carWashdate: carWashDate!,
            price: carPrice!,
            bookingStatus: BookingStatus.confirmed,
            bookingDate: DateTime.now(),
            serviceImageUrl: serviceImageUrl,
            serviceName: serviceName,
            timeSlot: timeSlot!));
        //Booking counter at admin Collection
        if (adminBookingsTotalCount.length < 9) {
          adminBookingCollectionCount.addAdminBookingCount(
              FavouriteServiceCounter(
                  userId: adminId!,
                  count: "0${adminBookingsTotalCount.length + 1}"));
        } else {
          adminBookingCollectionCount.addAdminBookingCount(
              FavouriteServiceCounter(
                  userId: adminId!,
                  count: "${adminBookingsTotalCount.length + 1}"));
        }
        // Booking counter for client side
        if (userBookingsTotalCount.length < 9) {
          userBookingCountCollection.addUserBookingCount(UserBookingCounter(
              userId: userId, count: "0${userBookingsTotalCount.length + 1}"));
        } else {
          userBookingCountCollection.addUserBookingCount(UserBookingCounter(
              userId: userId, count: "${userBookingsTotalCount.length + 1}"));
        }
        await getBookings(userId);
      }
    } catch (e) {
      log("Error in adding Booking : ${e.toString()} ");
    }
  }

  Future<void> getBookings(String userId) async {
    state = BookingLoadingState();
    try {
      var listOfClientBookings = await bookingCollection.getAllBookings(userId);
      var listOfAdminBookings =
          await bookingCollection.getAllBookings(adminId!);
      state = BookingLoadedState(
          listOfClientBookings: listOfClientBookings,
          listOfAdminBookings: listOfAdminBookings);
    } catch (e) {
      state = BookingErrorState(error: e.toString());
    }
  }
}

abstract class BookingStates {}

class BookingIntialState extends BookingStates {}

class BookingLoadingState extends BookingStates {}

class BookingLoadedState extends BookingStates {
  final List<Bookings> listOfClientBookings;
  final List<Bookings> listOfAdminBookings;
  BookingLoadedState(
      {required this.listOfClientBookings, required this.listOfAdminBookings});
}

class BookingErrorState extends BookingStates {
  final String error;
  BookingErrorState({required this.error});
}
