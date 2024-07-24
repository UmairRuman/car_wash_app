import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';
import 'package:car_wash_app/ModelClasses/bookings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingsIntialStateProvider =
    NotifierProvider<IntialBookingController, InitialBookingStates>(
        IntialBookingController.new);

class IntialBookingController extends Notifier<InitialBookingStates> {
  List<Bookings> listOfBookings = [];
  BookingCollection bookingCollection = BookingCollection();
  @override
  InitialBookingStates build() {
    return InitialBookingsInitiaState();
  }

  Future<void> getAllInitialBookings() async {
    // await Future.delayed(const Duration(seconds: 3));
    // state = InitialBookingsLoadingState();

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      var getListOfBookings = await bookingCollection.getAllBookings(userId);
      listOfBookings = getListOfBookings;
      // state = InitialBookingsLoadedState(listOfbookings: listOfBookings);
    } catch (e) {
      log("Error in getting intial list of Bookings");
      state = InitialBookingsErrorState(error: e.toString());
    }
  }
}

abstract class InitialBookingStates {}

class InitialBookingsInitiaState extends InitialBookingStates {}

class InitialBookingsLoadingState extends InitialBookingStates {}

class InitialBookingsLoadedState extends InitialBookingStates {
  final List<Bookings> listOfbookings;
  InitialBookingsLoadedState({required this.listOfbookings});
}

class InitialBookingsErrorState extends InitialBookingStates {
  final String error;
  InitialBookingsErrorState({required this.error});
}
