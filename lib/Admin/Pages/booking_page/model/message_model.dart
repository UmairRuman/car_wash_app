// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part "message_model.g.dart";

@HiveType(typeId: 0)
class MessageModel {
  @HiveField(1)
  String messageTitle;
  @HiveField(2)
  String messageBody;
  @HiveField(3)
  String messageDeliveredDate;
  MessageModel({
    required this.messageTitle,
    required this.messageBody,
    required this.messageDeliveredDate,
  });

  MessageModel copyWith({
    String? messageTitle,
    String? messageBody,
    String? messageDeliveredDate,
  }) {
    return MessageModel(
      messageTitle: messageTitle ?? this.messageTitle,
      messageBody: messageBody ?? this.messageBody,
      messageDeliveredDate: messageDeliveredDate ?? this.messageDeliveredDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageTitle': messageTitle,
      'messageBody': messageBody,
      'messageDeliveredDate': messageDeliveredDate,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageTitle: map['messageTitle'] as String,
      messageBody: map['messageBody'] as String,
      messageDeliveredDate: map['messageDeliveredDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageModel(messageTitle: $messageTitle, messageBody: $messageBody, messageDeliveredDate: $messageDeliveredDate)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.messageTitle == messageTitle &&
        other.messageBody == messageBody &&
        other.messageDeliveredDate == messageDeliveredDate;
  }

  @override
  int get hashCode =>
      messageTitle.hashCode ^
      messageBody.hashCode ^
      messageDeliveredDate.hashCode;
}
