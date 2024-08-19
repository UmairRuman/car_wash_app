import 'dart:developer';

import 'package:car_wash_app/Client/pages/NotificationPage/model/notification_model.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      final now = DateTime.now();
      final cutoff = now.subtract(const Duration(hours: 24));

      var query = await UserCollection.userCollection
          .doc(userId)
          .collection(NotificationCollection.notificationCollection)
          .where('notificationDeliveredDate',
              isLessThanOrEqualTo: Timestamp.fromDate(cutoff))
          .get();

      for (var doc in query.docs) {
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
