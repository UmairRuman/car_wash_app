import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
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
  final adminId = prefs!.getString(SharedPreferncesConstants.adminkey);
  DateTime dateTimeForFilter =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().hour);
  List<Bookings> intialListOfBookingsForClient = [];
  List<Bookings> intialListOfBookingsForAdmin = [];
  List<Bookings> finalListForAdmin = [];

  BookingCollection bookingCollection = BookingCollection();
  @override
  InitialBookingStates build() {
    return InitialBookingsInitiaState();
  }

  Future<void> getIntialNotifications() async {}

  Future<void> getAllInitialBookings() async {
    // await Future.delayed(const Duration(seconds: 3));
    // state = InitialBookingsLoadingState();

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      intialListOfBookingsForClient =
          await bookingCollection.getAllBookings(userId);
      intialListOfBookingsForAdmin =
          await bookingCollection.getAllBookings(adminId!);
      log("Intial length of Bookings of Admin : ${intialListOfBookingsForAdmin.toString()}");

      for (int index = 0;
          index < intialListOfBookingsForAdmin.length;
          index++) {
        if (intialListOfBookingsForAdmin[index].carWashdate ==
            dateTimeForFilter) {
          log("Both dates are equal");
          finalListForAdmin.add(intialListOfBookingsForAdmin[index]);
          log("Final intial List : ${finalListForAdmin.toString()} ");
        }
      }

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
