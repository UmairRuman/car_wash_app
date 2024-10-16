import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/firebase_notifications/message_sender.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/payment_methods/paypal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget payPallmethod(
    BuildContext context,
    int amount,
    List<PaypalItems> paypalItems,
    String serviceName,
    String serviceImagPath,
    String serviceId,
    DateTime carWashDate,
    WidgetRef ref) {
  TimeSlotCollection timeSlotCollection = TimeSlotCollection();
  String adminId = prefs!.getString(SharedPreferncesConstants.adminkey) ?? "";
  MessageDatabase messageDatabase = MessageDatabase();
  MessageSender messageSender = MessageSender();
  AdminDeviceTokenCollection adminDeviceTokenCollection =
      AdminDeviceTokenCollection();
  // Calculate subtotal based on the items
  double subtotal =
      paypalItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  log("Total Amount: $amount");
  log("Subtotal: $subtotal");

  if (subtotal != amount) {
    log("Error: Subtotal does not match the total amount");
    return Container();
  }

  return PaypalCheckout(
    sandboxMode: true,
    clientId: clientId,
    secretKey: paypalSecretKey,
    returnURL: "success.snippetcoder.com",
    cancelURL: "cancel.snippetcoder.com",
    transactions: [
      {
        "amount": {
          "total": amount.toString(),
          "currency": "USD",
          "details": {
            "subtotal": subtotal.toString(),
            "shipping": '0',
            "shipping_discount": 0
          }
        },
        "description": "The payment transaction description.",
        "item_list": {
          "items": paypalItems
              .map((item) => {
                    "name": item.name,
                    "quantity": item.quantity,
                    "price": item.price.toString(),
                    "currency": "USD"
                  })
              .toList(),
        }
      }
    ],
    note: "Contact us for any questions on your order.",
    onSuccess: (Map params) async {
      log("payment SuccessFull ");
      try {
        informerDialog(context, "Reserving Slot...");
        await ref
            .read(bookingStateProvider.notifier)
            .addBooking(serviceId, serviceName, serviceImagPath);

        await timeSlotCollection.deleteSpecificTimeSlot(
            adminId,
            ref.read(timeSlotsStateProvider.notifier).indexOfTimeSlot,
            carWashDate);

        //If the payement is successFull then we have to  send notifications to all admin

        //Show toast to user for successfully reservation of slot
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "You have reserved slot successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: Colors.green);
        Navigator.pop(context);
        Navigator.pop(context);

        await ref
            .read(messageStateProvider.notifier)
            .getAllNotificationsByUserId();
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
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Payment Failed ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        log("Payement Failed");
        log(e.toString());
      }

      log("onSuccess: $params");
    },
    onError: (error) {
      log("onError: $error");
      Navigator.pop(context);
    },
    onCancel: () {
      log('cancelled:');
    },
  );
}

class PaypalItems {
  final String name;
  final int quantity;
  final double price;

  PaypalItems(
      {required this.name, required this.quantity, required this.price});
}
