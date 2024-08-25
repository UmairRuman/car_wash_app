import 'dart:developer';
import 'dart:isolate';

import 'package:car_wash_app/Client/pages/NotificationPage/Database/notification_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

// Singleton class to manage the isolate state
class BookingCleanupIsolateManager {
  static BookingCleanupIsolateManager? _instance;
  Isolate? _cleanupIsolate;

  BookingCleanupIsolateManager._internal();

  static BookingCleanupIsolateManager get instance {
    _instance ??= BookingCleanupIsolateManager._internal();
    return _instance!;
  }

  bool get isIsolateRunning => _cleanupIsolate != null;

  Future<void> startBookingCleanup(String userId) async {
    if (_cleanupIsolate != null) {
      log("Cleanup isolate is already running.");
      return;
    }

    final rootIsolateToken = RootIsolateToken.instance;
    if (rootIsolateToken != null) {
      log("Starting booking cleanup isolate...");
      _cleanupIsolate = await Isolate.spawn(
        bookingsBackgroundCleanup,
        [userId, rootIsolateToken],
      );
    } else {
      log("Failed to get RootIsolateToken.");
    }
  }

  void stopCleanupIsolate() {
    _cleanupIsolate?.kill(priority: Isolate.immediate);
    _cleanupIsolate = null;
    log("Booking cleanup isolate stopped.");
  }
}

// Function to be called from your page
void startBookingsBackgroundCleanup(String userId) {
  BookingCleanupIsolateManager.instance.startBookingCleanup(userId);
}

void bookingsBackgroundCleanup(List<Object> params) async {
  log("In background cleanup function");
  final userId = params[0] as String;
  final rootIsolateToken = params[1] as RootIsolateToken;

  // Initialize the background isolate with the root token
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // Initialize Firebase in the isolate
  await Firebase.initializeApp();

  BookingCollection bookingCollection = BookingCollection();
  await bookingCollection.deleteOldBookings(userId);

  log("Booking cleanup completed.");
}
