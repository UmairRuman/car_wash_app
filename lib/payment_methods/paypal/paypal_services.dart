import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/ModelClasses/admin_info.dart';
import 'package:car_wash_app/firebase_notifications/message_sender.dart';
import 'package:car_wash_app/payment_methods/model/paypal_model.dart';
import 'package:car_wash_app/payment_methods/paypal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget payPallmethod(
    BuildContext context,
    int amount,
    List<PaypalItems> paypalItems,
    String serviceName,
    String serviceImagPath,
    int serviceId,
    WidgetRef ref) {
  MessageSender messageSender = MessageSender();
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  // Calculate subtotal based on the items
  double subtotal =
      paypalItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  log("Total Amount: $amount");
  log("Subtotal: $subtotal");

  // Check if subtotal matches the amount
  if (subtotal != amount) {
    log("Error: Subtotal does not match the total amount");
    return Container(); // or handle the error appropriately
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
      var adminInfo = await adminInfoCollection.getAdminsInfoAtSpecificId(1);
      log("payment SuccessFull ");
      ref
          .read(bookingStateProvider.notifier)
          .addBooking(serviceId, serviceName, serviceImagPath);
      messageSender.sendMessage(adminInfo.adminDeviceToken);
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
