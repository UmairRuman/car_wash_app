import 'package:car_wash_app/Admin/Pages/booking_page/model/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessageDatabase {
  static final instance = MessageDatabase._internal();
  MessageDatabase._internal();
  static const String messageBox = "message_box";

  factory MessageDatabase() {
    return instance;
  }

  static Future<void> initializeHiveDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageModelAdapter());
    await Hive.openBox<MessageModel>(messageBox);
  }

  Future<bool> addMessage(MessageModel messageModel) async {
    try {
      final box = Hive.box<MessageModel>(messageBox);
      await box.add(messageModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMessage(int index) async {
    try {
      final box = Hive.box<MessageModel>(messageBox);
      await box.deleteAt(index);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateMessage(int index, MessageModel newMessageModel) async {
    try {
      final box = Hive.box<MessageModel>(messageBox);
      await box.putAt(index, newMessageModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<MessageModel> getMessages() {
    final box = Hive.box<MessageModel>(messageBox);
    return box.values.toList();
  }

  MessageModel? getMessage(int index) {
    final box = Hive.box<MessageModel>(messageBox);
    return box.getAt(index);
  }
}
