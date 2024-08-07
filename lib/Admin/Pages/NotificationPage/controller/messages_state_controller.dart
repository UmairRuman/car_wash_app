import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/model/message_model.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageStateProvider =
    NotifierProvider<MessagesStateController, MessageStates>(
        MessagesStateController.new);

class MessagesStateController extends Notifier<MessageStates> {
  final adminId = prefs!.getString(SharedPreferncesConstants.adminkey);
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  List<MessageModel> listOfIntialMessage = [];
  MessageDatabase messageDatabase = MessageDatabase();
  @override
  MessageStates build() {
    return MessageIntialState();
  }

  Future<void> intialMessages() async {
    try {
      listOfIntialMessage = messageDatabase.getMessagesByUserId(currentUserId);
      log("List Of Intial Messages ${listOfIntialMessage.toString()}");
    } catch (e) {
      log("Error in getting intial messages");
    }
  }

  Future<void> addNotificationAtAdminSide(String bookerName, String serviceName,
      DateTime carWashDate, String timeSlot) async {
    try {
      String messageTitle = "New booking made at $carWashDate";
      String messageBody =
          "$bookerName booked $timeSlot timeslot for $serviceName";
      String date =
          "${carWashDate.day}-${carWashDate.month}${carWashDate.year}";

      MessageModel messageModel = MessageModel(
          userId: adminId!,
          messageTitle: messageTitle,
          messageBody: messageBody,
          messageDeliveredDate: date);
      await messageDatabase.addMessage(messageModel);
      log("Message is added at admin side");
    } catch (e) {
      log("Error in adding notification at admin Side");
    }
  }

  Future<void> addNotificationAtUserSide(String bookerName, String serviceName,
      DateTime carWashDate, String timeSlot) async {
    try {
      String messageTitle = "You have successfully booked $serviceName";
      String messageBody =
          "You have booked $timeSlot timeslot for $serviceName ";
      String date =
          "${carWashDate.day}-${carWashDate.month}${carWashDate.year}";

      MessageModel messageModel = MessageModel(
          userId: currentUserId,
          messageTitle: messageTitle,
          messageBody: messageBody,
          messageDeliveredDate: date);
      await messageDatabase.addMessage(messageModel);
      log("Message is added at user side");
    } catch (e) {
      log("Error in adding notification at user Side");
    }
  }

  Future<void> getAllNotificationsByUserId() async {
    state = MessageLoadingState();
    try {
      var listOfMessage = messageDatabase.getMessagesByUserId(currentUserId);
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
  final List<MessageModel> listOfMessageModel;
  const MessageLoadedState({required this.listOfMessageModel});
}

class MessageErrorState extends MessageStates {
  final String error;
  const MessageErrorState({required this.error});
}
