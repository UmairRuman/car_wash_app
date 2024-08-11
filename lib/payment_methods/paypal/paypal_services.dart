import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/model/message_model.dart';
import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/ModelClasses/admin_info.dart';
import 'package:car_wash_app/firebase_notifications/message_sender.dart';
import 'package:car_wash_app/payment_methods/model/paypal_model.dart';
import 'package:car_wash_app/payment_methods/paypal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
      await ref
          .read(bookingStateProvider.notifier)
          .addBooking(serviceId, serviceName, serviceImagPath);

      //If the payement is successFull then we have to  send notifications to all admin

      //Show toast to user for successfully reservation of slot

      Fluttertoast.showToast(
          msg: "You have reserved slot successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.green);

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
