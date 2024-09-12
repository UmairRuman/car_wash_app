import 'dart:developer';
import 'dart:isolate';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/BookingCollections/booking_collextion.dart';
import 'package:flutter/services.dart';

class BookingCleanupIsolateManager {
  static BookingCleanupIsolateManager? _instance;
  Isolate? _cleanupIsolate;
  ReceivePort? _receivePort;

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

    _receivePort = ReceivePort();
    _receivePort!.listen((message) {
      // Perform Firebase cleanup in the main isolate
      if (message == 'cleanup') {
        deleteOldBookings(userId);
      }
    });

    final rootIsolateToken = RootIsolateToken.instance;
    if (rootIsolateToken != null) {
      log("Starting booking cleanup isolate...");
      _cleanupIsolate = await Isolate.spawn(
        bookingsBackgroundCleanup,
        [_receivePort!.sendPort, rootIsolateToken],
      );
    } else {
      log("Failed to get RootIsolateToken.");
    }
  }

  void stopCleanupIsolate() {
    _cleanupIsolate?.kill(priority: Isolate.immediate);
    _cleanupIsolate = null;
    _receivePort?.close();
    log("Booking cleanup isolate stopped.");
  }

  Future<void> deleteOldBookings(String userId) async {
    log("Performing Firebase cleanup on the main isolate...");
    BookingCollection bookingCollection = BookingCollection();
    await bookingCollection.deleteOldBookings(userId);
    log("Booking cleanup completed.");
  }
}

// Function to be called from your page
void startBookingsBackgroundCleanup(String userId) {
  BookingCleanupIsolateManager.instance.startBookingCleanup(userId);
}

void bookingsBackgroundCleanup(List<Object> params) async {
  log("In background cleanup function");
  final sendPort = params[0] as SendPort;
  final rootIsolateToken = params[1] as RootIsolateToken;

  // Initialize the background isolate with the root token
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // Perform non-Firebase heavy computation if needed

  // Notify the main isolate to perform the cleanup
  sendPort.send('cleanup');
}
