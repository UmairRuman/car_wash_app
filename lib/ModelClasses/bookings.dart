// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Bookings {
  String bookingId;
  String userId;
  String serviceId;
  String carName;
  DateTime carWashdate;
  double price;
  String bookingStatus;
  DateTime bookingDate;
  String serviceName;
  Map<String, String> timeSlot;
  Bookings({
    required this.bookingId,
    required this.userId,
    required this.serviceId,
    required this.carName,
    required this.carWashdate,
    required this.price,
    required this.bookingStatus,
    required this.bookingDate,
    required this.serviceName,
    required this.timeSlot,
  });

  Bookings copyWith({
    String? bookingId,
    String? userId,
    String? serviceId,
    String? carName,
    DateTime? carWashdate,
    double? price,
    String? bookingStatus,
    DateTime? bookingDate,
    String? serviceName,
    Map<String, String>? timeSlot,
  }) {
    return Bookings(
      bookingId: bookingId ?? this.bookingId,
      userId: userId ?? this.userId,
      serviceId: serviceId ?? this.serviceId,
      carName: carName ?? this.carName,
      carWashdate: carWashdate ?? this.carWashdate,
      price: price ?? this.price,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingDate: bookingDate ?? this.bookingDate,
      serviceName: serviceName ?? this.serviceName,
      timeSlot: timeSlot ?? this.timeSlot,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookingId': bookingId,
      'userId': userId,
      'serviceId': serviceId,
      'carName': carName,
      'carWashdate': carWashdate.millisecondsSinceEpoch,
      'price': price,
      'bookingStatus': bookingStatus,
      'bookingDate': bookingDate.millisecondsSinceEpoch,
      'serviceName': serviceName,
      'timeSlot': timeSlot,
    };
  }

  factory Bookings.fromMap(Map<String, dynamic> map) {
    return Bookings(
        bookingId: map['bookingId'] as String,
        userId: map['userId'] as String,
        serviceId: map['serviceId'] as String,
        carName: map['carName'] as String,
        carWashdate:
            DateTime.fromMillisecondsSinceEpoch(map['carWashdate'] as int),
        price: map['price'] as double,
        bookingStatus: map['bookingStatus'] as String,
        bookingDate:
            DateTime.fromMillisecondsSinceEpoch(map['bookingDate'] as int),
        serviceName: map['serviceName'] as String,
        timeSlot: Map<String, String>.from(
          (map['timeSlot'] as Map<String, String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Bookings.fromJson(String source) =>
      Bookings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bookings(bookingId: $bookingId, userId: $userId, serviceId: $serviceId, carName: $carName, carWashdate: $carWashdate, price: $price, bookingStatus: $bookingStatus, bookingDate: $bookingDate, serviceName: $serviceName, timeSlot: $timeSlot)';
  }

  @override
  bool operator ==(covariant Bookings other) {
    if (identical(this, other)) return true;

    return other.bookingId == bookingId &&
        other.userId == userId &&
        other.serviceId == serviceId &&
        other.carName == carName &&
        other.carWashdate == carWashdate &&
        other.price == price &&
        other.bookingStatus == bookingStatus &&
        other.bookingDate == bookingDate &&
        other.serviceName == serviceName &&
        mapEquals(other.timeSlot, timeSlot);
  }

  @override
  int get hashCode {
    return bookingId.hashCode ^
        userId.hashCode ^
        serviceId.hashCode ^
        carName.hashCode ^
        carWashdate.hashCode ^
        price.hashCode ^
        bookingStatus.hashCode ^
        bookingDate.hashCode ^
        serviceName.hashCode ^
        timeSlot.hashCode;
  }
}
