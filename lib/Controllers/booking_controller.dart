import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';

import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/admin_booking_collection_count.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/user_booking_count_collection.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
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
  var adminId = prefs!.getString(SharedPreferncesConstants.adminkey) == ""
      ? FirebaseAuth.instance.currentUser!.uid
      : prefs!.getString(SharedPreferncesConstants.adminkey);
  DateTime dateTimeForFilter =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  MessageDatabase messageDatabase = MessageDatabase();
  String? carType;
  DateTime? carWashDate;
  String? carPrice;
  String? timeSlot;
  bool? isCarAssetImage;
  String? carImagePath;
  List<Bookings> listOfAdminRealBookings = [];
  UserCollection userCollection = UserCollection();
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
      final bookerName = FirebaseAuth.instance.currentUser!.displayName;
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
        String phoneNo = FirebaseAuth.instance.currentUser!.phoneNumber ?? "";
        //Adding Booking in client Collection
        bookingCollection.addBooking(Bookings(
            bookerPhoneNo: phoneNo,
            bookerName: bookerName!,
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
            bookerPhoneNo: phoneNo,
            bookerName: bookerName,
            userBookingId: adminBookingId,
            userId: adminId!,
            serviceId: serviceId.toString(),
            carType: carType!,
            carWashdate: carWashDate!,
            price: carPrice!,
            bookingStatus: BookingStatus.confirmed,
            bookingDate: DateTime.now(),
            serviceImageUrl: serviceImageUrl,
            serviceName: serviceName,
            timeSlot: timeSlot!));
        //After adding booking we also have to add bonus points and no of services to user and admin side
        await userCollection.updateUserNoOfServices(userId);
        await userCollection.updateUserNoOfServices(adminId!);
        await userCollection.updateUserBonusPoints(userId);
        //Adding Message to the Admin Side to show Admin messages of one day
        log("Reached at Adding messages");
        await ref
            .read(messageStateProvider.notifier)
            .addNotificationAtAdminSide(
                bookerName, serviceName, carWashDate!, timeSlot!);
        //Adding messages to the user side
        await ref.read(messageStateProvider.notifier).addNotificationAtUserSide(
            bookerName, serviceName, carWashDate!, timeSlot!);

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
        // await getBookings(userId);

        await ref
            .read(messageStateProvider.notifier)
            .getAllNotificationsByUserId();
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
      //After getting admin latest bookings we have to navigate admin to the booking page
      listOfAdminRealBookings = [];
      if (listOfAdminBookings.isNotEmpty) {
        for (int index = 0; index < listOfAdminBookings.length; index++) {
          var carWashdate = listOfAdminBookings[index].carWashdate;
          var filterDate = dateTimeForFilter;
          if (carWashdate == filterDate) {
            listOfAdminBookings.add(listOfAdminBookings[index]);
            state = BookingLoadedState(
                listOfClientBookings: listOfClientBookings,
                listOfAdminBookings: listOfAdminRealBookings);
          }
        }
      }
    } catch (e) {
      log("Error in getting Admin Side Bookings");
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
