import 'dart:developer';
import 'dart:isolate';

import 'package:car_wash_app/Client/pages/NotificationPage/Database/notification_collection.dart';
import 'package:flutter/services.dart';

class NotificationCleanupIsolateManager {
  static NotificationCleanupIsolateManager? _instance;
  Isolate? _cleanupIsolate;
  ReceivePort? _receivePort;

  NotificationCleanupIsolateManager._internal();

  static NotificationCleanupIsolateManager get instance {
    _instance ??= NotificationCleanupIsolateManager._internal();
    return _instance!;
  }

  bool get isIsolateRunning => _cleanupIsolate != null;

  Future<void> startNotificationCleanup(String userId) async {
    if (_cleanupIsolate != null) {
      log("Notification cleanup isolate is already running.");
      return;
    }

    _receivePort = ReceivePort();
    _receivePort!.listen((message) {
      // Perform Firebase cleanup in the main isolate
      if (message == 'cleanup') {
        deleteOldNotifications(userId);
      }
    });

    final rootIsolateToken = RootIsolateToken.instance;
    if (rootIsolateToken != null) {
      log("Starting notification cleanup isolate...");
      _cleanupIsolate = await Isolate.spawn(
        notificationsBackgroundCleanup,
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
    log("Notification cleanup isolate stopped.");
  }

  Future<void> deleteOldNotifications(String userId) async {
    log("Performing Firebase cleanup on the main isolate...");
    NotificationCollection notificationCollection = NotificationCollection();
    await notificationCollection.deleteOldNotifications(userId);
    log("Notification cleanup completed.");
  }
}

// Function to be called from your page to start notification cleanup
void startNotificationBackgroundCleanup(String userId) {
  NotificationCleanupIsolateManager.instance.startNotificationCleanup(userId);
}

void notificationsBackgroundCleanup(List<Object> params) async {
  log("In background cleanup function for notifications");
  final sendPort = params[0] as SendPort;
  final rootIsolateToken = params[1] as RootIsolateToken;

  // Initialize the background isolate with the root token
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // Perform non-Firebase heavy computation if needed

  // Notify the main isolate to perform the cleanup
  sendPort.send('cleanup');
}
