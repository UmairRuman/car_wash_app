import 'dart:developer';

import 'package:car_wash_app/Client/pages/NotificationPage/model/notification_model.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCollection {
  static final NotificationCollection instance =
      NotificationCollection._internal();
  NotificationCollection._internal();
  static const String notificationCollection = "Notification Collection";
  factory NotificationCollection() {
    return instance;
  }

  Future<bool> addNotification(NotificationModel notificationModel) async {
    try {
      log("In Add notification method");
      await UserCollection.userCollection
          .doc(notificationModel.userId)
          .collection(notificationCollection)
          .doc(
              "${notificationModel.timeSlot} at ${notificationModel.carWashDate.day}")
          .set(notificationModel.toMap());

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteNotification(NotificationModel notificationModel) async {
    try {
      await UserCollection.userCollection
          .doc(notificationModel.userId)
          .collection(notificationCollection)
          .doc(
              "${notificationModel.timeSlot} at ${notificationModel.carWashDate.day}")
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNotification(NotificationModel notificationModel) async {
    try {
      await UserCollection.userCollection
          .doc(notificationModel.userId)
          .collection(notificationCollection)
          .doc(
              "${notificationModel.timeSlot} at ${notificationModel.carWashDate.day}")
          .update(notificationModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteOldNotifications(String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final adminId = prefs.getString(SharedPreferncesConstants.adminkey) == ""
          ? FirebaseAuth.instance.currentUser!.uid
          : prefs.getString(SharedPreferncesConstants.adminkey);
      final isServiceProvider =
          prefs.getBool(SharedPreferncesConstants.isServiceProvider);
      int hours = 168; // Default to 1 week (168 hours) for the admin

      // If the user is a client
      if (currentUserId != adminId &&
          isServiceProvider != null &&
          !isServiceProvider) {
        var allNotification = await fetchAllNotification(currentUserId);

        // Ensure there are bookings to process
        if (allNotification.isNotEmpty) {
          final clientCutoff =
              allNotification.last.carWashDate.add(const Duration(hours: 24));
          log("Clinet Cut off $clientCutoff");
          // Ensure the cutoff is not in the future to avoid negative hours
          if (clientCutoff.isBefore(DateTime.now())) {
            hours = DateTime.now().difference(clientCutoff).inHours;
          } else {
            // If cutoff is in the future, set hours to 0 to avoid deletion
            hours = 0;
          }
        }
      }

      log("In delete Old notifications ");
      final now = DateTime.now();
      final cutoff = now.subtract(Duration(hours: hours));

      var query = await UserCollection.userCollection
          .doc(userId)
          .collection(NotificationCollection.notificationCollection)
          .where('carWashDate', isLessThanOrEqualTo: Timestamp.fromDate(cutoff))
          .get();

      for (var doc in query.docs) {
        log("Notification to be Delete $doc");
        await doc.reference.delete();
      }
    } catch (e) {
      log("Error deleting old notifications: $e");
    }
  }

  Future<List<NotificationModel>> fetchAllNotification(String userId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(notificationCollection)
          .orderBy("notificationDeliveredDate", descending: false)
          .get();

      return querrySnapshots.docs
          .map(
            (doc) => NotificationModel.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
