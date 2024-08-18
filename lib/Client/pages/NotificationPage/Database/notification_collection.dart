import 'dart:developer';

import 'package:car_wash_app/Client/pages/NotificationPage/model/notification_model.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';

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
