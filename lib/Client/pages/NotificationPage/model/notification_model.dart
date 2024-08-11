// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String timeSlot;
  DateTime carWashDate;
  String serviceName;
  String userId;
  String bookerName;
  String bookerPic;
  NotificationModel({
    required this.timeSlot,
    required this.carWashDate,
    required this.serviceName,
    required this.userId,
    required this.bookerName,
    required this.bookerPic,
  });

  NotificationModel copyWith({
    String? timeSlot,
    DateTime? carWashDate,
    String? serviceName,
    String? userId,
    String? bookerName,
    String? bookerPic,
  }) {
    return NotificationModel(
      timeSlot: timeSlot ?? this.timeSlot,
      carWashDate: carWashDate ?? this.carWashDate,
      serviceName: serviceName ?? this.serviceName,
      userId: userId ?? this.userId,
      bookerName: bookerName ?? this.bookerName,
      bookerPic: bookerPic ?? this.bookerPic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeSlot': timeSlot,
      'carWashDate': Timestamp.fromDate(carWashDate),
      'serviceName': serviceName,
      'userId': userId,
      'bookerName': bookerName,
      'bookerPic': bookerPic,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      timeSlot: map['timeSlot'] as String,
      carWashDate: (map['carWashDate'] as Timestamp).toDate(),
      serviceName: map['serviceName'] as String,
      userId: map['userId'] as String,
      bookerName: map['bookerName'] as String,
      bookerPic: map['bookerPic'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(timeSlot: $timeSlot, carWashDate: $carWashDate, serviceName: $serviceName, userId: $userId, bookerName: $bookerName, bookerPic: $bookerPic)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.timeSlot == timeSlot &&
        other.carWashDate == carWashDate &&
        other.serviceName == serviceName &&
        other.userId == userId &&
        other.bookerName == bookerName &&
        other.bookerPic == bookerPic;
  }

  @override
  int get hashCode {
    return timeSlot.hashCode ^
        carWashDate.hashCode ^
        serviceName.hashCode ^
        userId.hashCode ^
        bookerName.hashCode ^
        bookerPic.hashCode;
  }
}
