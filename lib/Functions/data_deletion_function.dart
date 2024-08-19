import 'dart:developer';
import 'dart:isolate';

import 'package:car_wash_app/Client/pages/NotificationPage/Database/notification_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';

void startBackgroundCleanup(String userId) async {
  log("start background cleanup function run ");
  // Start the isolate
  Isolate.spawn(_backgroundCleanup, userId);
}

void _backgroundCleanup(String userId) async {
  NotificationCollection notificationCollection = NotificationCollection();
  BookingCollection bookingCollection = BookingCollection();
  await notificationCollection.deleteOldNotifications(userId);
  await bookingCollection.deleteOldBookings(userId);
}
