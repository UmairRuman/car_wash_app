//Firstly we have to implement singelton of class
import 'dart:developer';

import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/firebase_notifications/message_sender.dart';
import 'package:car_wash_app/payment_methods/Stripe/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StripeServices {
  BookingCollection bookingCollection = BookingCollection();

  AdminDeviceTokenCollection adminDeviceTokenCollection =
      AdminDeviceTokenCollection();
  StripeServices._internal();
  MessageSender messageSender = MessageSender();
  static final StripeServices instance = StripeServices._internal();

  Future<void> makePayment(
      int amount,
      String currency,
      String serviceId,
      String serviceName,
      WidgetRef ref,
      String serviceImageUrl,
      DateTime carWashDate,
      BuildContext context) async {
    try {
      informerDialog(context, "Opening Payment Sheet");
      String? paymentIntentClientSecret =
          await createPaymentIntent(amount, currency);
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "Umair Ruman",
      ));
      Navigator.pop(context);
      await processPaymentSheet(
          serviceId, serviceName, ref, serviceImageUrl, carWashDate, context);
      log("Paid");
    } catch (e) {
      log("Error in making payment ${e.toString()}");
    }
  }

  //This function is not susposed to be at front end , for production pourpose we have to make cloud function and invoke cloud function as we need payment intent
  Future<String?> createPaymentIntent(int amount, String currency) async {
    try {
      Dio dio = Dio();
      Map<String, dynamic> data = {
        //The amount we mentioned here is converted int cents , 100 cents = 1 dollar , so if we have to input 10 dollars then we have to mention 1000 cents
        "amount": calculatedAmount(amount),
        "currency": currency
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          "Authorization": "Bearer $stripeSecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        }),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      } else {
        return null;
      }
    } catch (e) {
      log("Error in creating intent : ${e.toString()}");
    }
    return null;
  }

  Future<void> processPaymentSheet(
      String serviceId,
      String serviceName,
      WidgetRef ref,
      String serviceImageUrl,
      DateTime carWashDate,
      BuildContext context) async {
    try {
      //We have to call this when we want to open present Payment sheet
      await Stripe.instance.presentPaymentSheet();

      log("payment SuccessFull ");
      log("Adding Bookings");
      informerDialog(context, "Reserving Slot...");
      await ref
          .read(bookingStateProvider.notifier)
          .addBooking(serviceId, serviceName, serviceImageUrl);

      //Show toast to user for successfully reservation of slot
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "You have reserved slot successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.green);
      //When the payment is successfull then we have to send messages to admins by taking their token
      // await ref
      //     .read(bookingStateProvider.notifier)
      //     .getBookings(FirebaseAuth.instance.currentUser!.uid);
      log("Getting all admins Id ");
      await ref
          .read(messageStateProvider.notifier)
          .getAllNotificationsByUserId();
      log("Getting all bookings ");
      // await ref
      //     .read(bookingStateProvider.notifier)
      //     .getBookings(FirebaseAuth.instance.currentUser!.uid);
      var listOfAdminToken =
          await adminDeviceTokenCollection.getAllAdminDeviceTokens();

      for (int index = 0; index < listOfAdminToken.length; index++) {
        messageSender.sendMessage(
          listOfAdminToken[index].deviceToken,
          data: {
            'car_wash_date':
                carWashDate.toIso8601String(), // include car wash date
          },
        );
      }

      //Below line will throw an exception if payment is unsuccessfull
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Payment Failed ,${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      log("Payement Failed");
      log(e.toString());
    }
  }

  String calculatedAmount(int amount) {
    int calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
