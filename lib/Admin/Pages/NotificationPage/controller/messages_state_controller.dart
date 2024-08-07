import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/model/message_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageStateProvider =
    NotifierProvider<MessagesStateController, MessageStates>(
        MessagesStateController.new);

class MessagesStateController extends Notifier<MessageStates> {
  List<MessageModel> listOfIntialMessage = [];
  MessageDatabase messageDatabase = MessageDatabase();
  @override
  MessageStates build() {
    return MessageIntialState();
  }

  Future<void> intialMessages() async {
    try {
      listOfIntialMessage = messageDatabase.getMessages();
    } catch (e) {
      log("Error in getting ");
    }
  }

  Future<void> getAllNotifications() async {
    state = MessageLoadingState();
    try {
      var listOfMessage = messageDatabase.getMessages();
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
