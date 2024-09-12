import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';
import 'package:car_wash_app/ModelClasses/bookings.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingsIntialStateProvider =
    NotifierProvider<IntialBookingController, InitialBookingStates>(
        IntialBookingController.new);

class IntialBookingController extends Notifier<InitialBookingStates> {
  final adminId = prefs!.getString(SharedPreferncesConstants.adminkey) == ""
      ? FirebaseAuth.instance.currentUser!.uid
      : prefs!.getString(SharedPreferncesConstants.adminkey);
  DateTime dateTimeForFilter =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<Bookings> intialListOfBookingsForClient = [];
  List<Bookings> intialListOfBookingsForAdmin = [];
  List<Bookings> finalListForAdmin = [];

  BookingCollection bookingCollection = BookingCollection();
  @override
  InitialBookingStates build() {
    return InitialBookingsInitiaState();
  }

  Future<void> getAllInitialBookings() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      state = InitialBookingsLoadingState();
      final userId = FirebaseAuth.instance.currentUser!.uid;
      intialListOfBookingsForClient =
          await bookingCollection.getAllBookings(userId);

      intialListOfBookingsForAdmin =
          await bookingCollection.getAllBookings(adminId!);
      finalListForAdmin = [];
      if (intialListOfBookingsForAdmin.isNotEmpty) {
        for (int index = 0;
            index < intialListOfBookingsForAdmin.length;
            index++) {
          try {
            var carWashdate = intialListOfBookingsForAdmin[index].carWashdate;
            var filterDate = dateTimeForFilter;

            if (normalizeDate(carWashdate) == normalizeDate(filterDate)) {
              log("Both dates are equal");

              finalListForAdmin.add(intialListOfBookingsForAdmin[index]);
              // log("Final initial List: ${finalListForAdmin.toString()}");
              state =
                  InitialBookingsLoadedState(listOfbookings: finalListForAdmin);
            } else {
              state =
                  InitialBookingsLoadedState(listOfbookings: finalListForAdmin);
            }
          } catch (e) {
            log("Error in loop at index $index: $e");
            state = InitialBookingsErrorState(error: e.toString());
          }
        }
      } else {
        state = InitialBookingsLoadedState(
            listOfbookings: intialListOfBookingsForAdmin);
      }
    } catch (e) {
      log("Error in getAllInitialBookings: $e");
      state = InitialBookingsErrorState(error: e.toString());
    }
  }

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
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
