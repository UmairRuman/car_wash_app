import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/admin_booking_collection_count.dart';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/user_booking_count_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/bookings_collection.dart';
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
  String? carType;
  DateTime? carWashDate;
  double? carPrice;
  String? timeSlot;
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
      int serviceId, String serviceName, String serviceImageUrl) async {
    try {
      final adminId = prefs!.getString(ShraedPreferncesConstants.adminkey)!;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      var adminBookingsTotalCount =
          await adminBookingCollectionCount.getAllUserBookingsCount(adminId);
      var userBookingsTotalCount =
          await userBookingCountCollection.getAllUserBookingsCount(userId);

      if (carWashDate != null &&
          carType != null &&
          carPrice != null &&
          timeSlot != null) {
        bookingCollection.addBooking(
            userId,
            Bookings(
                adminBookingId: adminBookingsTotalCount.length,
                userBookingId: userBookingsTotalCount.length,
                userId: userId,
                serviceId: serviceId.toString(),
                carType: carType!,
                carWashdate: carWashDate!,
                price: carPrice!,
                bookingStatus: BookingStatus.pending,
                bookingDate: DateTime.now(),
                serviceImageUrl: serviceImageUrl,
                serviceName: serviceName,
                timeSlot: timeSlot!));

        adminBookingCollectionCount.addAdminBookingCount(
            FavouriteServicesCounter(
                userId: adminId, count: adminBookingsTotalCount.length + 1));
        userBookingCountCollection.addUserBookingCount(UserBookingCounter(
            userId: userId, count: userBookingsTotalCount.length + 1));
      }
    } catch (e) {
      log("Error in adding Booking : ${e.toString()} ");
    }
  }

  Future<void> getBookings(String userId) async {
    state = BookingLoadingState();
    try {
      var listOfBookings = await bookingCollection.getAllBookings(userId);
      state = BookingLoadedState(listOfBookings: listOfBookings);
    } catch (e) {
      state = BookingErrorState(error: e.toString());
    }
  }
}

abstract class BookingStates {}

class BookingIntialState extends BookingStates {}

class BookingLoadingState extends BookingStates {}

class BookingLoadedState extends BookingStates {
  final List<Bookings> listOfBookings;
  BookingLoadedState({required this.listOfBookings});
}

class BookingErrorState extends BookingStates {
  final String error;
  BookingErrorState({required this.error});
}
