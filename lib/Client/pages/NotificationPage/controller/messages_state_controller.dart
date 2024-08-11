import 'dart:developer';

import 'package:car_wash_app/Client/pages/NotificationPage/Database/notification_collection.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/model/notification_model.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageStateProvider =
    NotifierProvider<MessagesStateController, MessageStates>(
        MessagesStateController.new);

class MessagesStateController extends Notifier<MessageStates> {
  final adminId = prefs!.getString(SharedPreferncesConstants.adminkey);
  UserCollection userCollection = UserCollection();
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  List<NotificationModel> listOfIntialMessage = [];
  NotificationCollection notificationCollection = NotificationCollection();
  @override
  MessageStates build() {
    return MessageIntialState();
  }

  Future<void> intialMessages() async {
    try {
      listOfIntialMessage =
          await notificationCollection.fetchAllNotification(currentUserId);
    } catch (e) {
      log("Error in getting intial messages");
    }
  }

  Future<void> addNotificationAtAdminSide(String bookerName, String serviceName,
      DateTime carWashDate, String timeSlot) async {
    String userProfilePic = await userCollection.getUserPic(currentUserId!);

    NotificationModel notificationModel = NotificationModel(
      serviceName: serviceName,
      bookerName: bookerName,
      bookerPic: userProfilePic,
      carWashDate: carWashDate,
      timeSlot: timeSlot,
      userId: adminId!,
    );
    await notificationCollection.addNotification(notificationModel);
  }

  Future<void> addNotificationAtUserSide(String bookerName, String serviceName,
      DateTime carWashDate, String timeSlot) async {
    String userProfilePic = await userCollection.getUserPic(currentUserId);
    NotificationModel notificationModel = NotificationModel(
      serviceName: serviceName,
      bookerName: bookerName,
      bookerPic: userProfilePic,
      carWashDate: carWashDate,
      timeSlot: timeSlot,
      userId: currentUserId,
    );
    await notificationCollection.addNotification(notificationModel);
  }

  Future<void> getAllNotificationsByUserId() async {
    log("Current User Id in Notification method $currentUserId");
    state = MessageLoadingState();
    try {
      var listOfMessage =
          await notificationCollection.fetchAllNotification(currentUserId);
      state = MessageLoadedState(listOfMessageModel: listOfMessage);
    } catch (e) {
      state = MessageErrorState(error: e.toString());
    }
  }
}

abstract class MessageStates {
  const MessageStates();
}

class MessageIntialState extends MessageStates {}

class MessageLoadingState extends MessageStates {}

class MessageLoadedState extends MessageStates {
  final List<NotificationModel> listOfMessageModel;
  const MessageLoadedState({required this.listOfMessageModel});
}

class MessageErrorState extends MessageStates {
  final String error;
  const MessageErrorState({required this.error});
}
