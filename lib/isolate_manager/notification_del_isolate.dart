import 'dart:isolate';
import 'dart:developer';
import 'dart:ui';
import 'package:car_wash_app/Client/pages/NotificationPage/Database/notification_collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Singleton class to manage the isolate state for notifications
class NotificationCleanupIsolateManager {
  static NotificationCleanupIsolateManager? _instance;
  Isolate? _cleanupIsolate;

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

    final rootIsolateToken = RootIsolateToken.instance;
    if (rootIsolateToken != null) {
      log("Starting notification cleanup isolate...");
      _cleanupIsolate = await Isolate.spawn(
        notificationsBackgroundCleanup,
        [userId, rootIsolateToken],
      );
    } else {
      log("Failed to get RootIsolateToken.");
    }
  }

  void stopCleanupIsolate() {
    _cleanupIsolate?.kill(priority: Isolate.immediate);
    _cleanupIsolate = null;
    log("Notification cleanup isolate stopped.");
  }
}

// Function to be called from your page to start notification cleanup
void startNotificationBackgroundCleanup(String userId) {
  NotificationCleanupIsolateManager.instance.startNotificationCleanup(userId);
}

void notificationsBackgroundCleanup(List<Object> params) async {
  log("In background cleanup function for notifications");
  final userId = params[0] as String;
  final rootIsolateToken = params[1] as RootIsolateToken;

  // Initialize the background isolate with the root token
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // Initialize Firebase in the isolate
  await Firebase.initializeApp();

  NotificationCollection notificationCollection = NotificationCollection();
  await notificationCollection.deleteOldNotifications(userId);

  log("Notification cleanup completed.");
}
