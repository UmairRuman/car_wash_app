// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Bookings {
  int userBookingId;
  int adminBookingId;
  String userId;
  String serviceId;
  String carType;
  DateTime carWashdate;
  double price;
  String bookingStatus;
  DateTime bookingDate;
  String serviceImageUrl;
  String serviceName;
  String timeSlot;
  Bookings({
    required this.userBookingId,
    required this.adminBookingId,
    required this.userId,
    required this.serviceId,
    required this.carType,
    required this.carWashdate,
    required this.price,
    required this.bookingStatus,
    required this.bookingDate,
    required this.serviceImageUrl,
    required this.serviceName,
    required this.timeSlot,
  });

  Bookings copyWith({
    int? userBookingId,
    int? adminBookingId,
    String? userId,
    String? serviceId,
    String? carType,
    DateTime? carWashdate,
    double? price,
    String? bookingStatus,
    DateTime? bookingDate,
    String? serviceImageUrl,
    String? serviceName,
    String? timeSlot,
  }) {
    return Bookings(
      userBookingId: userBookingId ?? this.userBookingId,
      adminBookingId: adminBookingId ?? this.adminBookingId,
      userId: userId ?? this.userId,
      serviceId: serviceId ?? this.serviceId,
      carType: carType ?? this.carType,
      carWashdate: carWashdate ?? this.carWashdate,
      price: price ?? this.price,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingDate: bookingDate ?? this.bookingDate,
      serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
      serviceName: serviceName ?? this.serviceName,
      timeSlot: timeSlot ?? this.timeSlot,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userBookingId': userBookingId,
      'adminBookingId': adminBookingId,
      'userId': userId,
      'serviceId': serviceId,
      'carType': carType,
      'carWashdate': Timestamp.fromDate(carWashdate),
      'price': price,
      'bookingStatus': bookingStatus,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'serviceImageUrl': serviceImageUrl,
      'serviceName': serviceName,
      'timeSlot': timeSlot,
    };
  }

  factory Bookings.fromMap(Map<String, dynamic> map) {
    return Bookings(
      userBookingId: map['userBookingId'] as int,
      adminBookingId: map['adminBookingId'] as int,
      userId: map['userId'] as String,
      serviceId: map['serviceId'] as String,
      carType: map['carType'] as String,
      carWashdate: (map['carWashdate'] as Timestamp).toDate(),
      price: map['price'] as double,
      bookingStatus: map['bookingStatus'] as String,
      bookingDate: (map['bookingDate'] as Timestamp).toDate(),
      serviceImageUrl: map['serviceImageUrl'] as String,
      serviceName: map['serviceName'] as String,
      timeSlot: map['timeSlot'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bookings.fromJson(String source) =>
      Bookings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bookings(userBookingId: $userBookingId, adminBookingId: $adminBookingId, userId: $userId, serviceId: $serviceId, carType: $carType, carWashdate: $carWashdate, price: $price, bookingStatus: $bookingStatus, bookingDate: $bookingDate, serviceImageUrl: $serviceImageUrl, serviceName: $serviceName, timeSlot: $timeSlot)';
  }

  @override
  bool operator ==(covariant Bookings other) {
    if (identical(this, other)) return true;

    return other.userBookingId == userBookingId &&
        other.adminBookingId == adminBookingId &&
        other.userId == userId &&
        other.serviceId == serviceId &&
        other.carType == carType &&
        other.carWashdate == carWashdate &&
        other.price == price &&
        other.bookingStatus == bookingStatus &&
        other.bookingDate == bookingDate &&
        other.serviceImageUrl == serviceImageUrl &&
        other.serviceName == serviceName &&
        other.timeSlot == timeSlot;
  }

  @override
  int get hashCode {
    return userBookingId.hashCode ^
        adminBookingId.hashCode ^
        userId.hashCode ^
        serviceId.hashCode ^
        carType.hashCode ^
        carWashdate.hashCode ^
        price.hashCode ^
        bookingStatus.hashCode ^
        bookingDate.hashCode ^
        serviceImageUrl.hashCode ^
        serviceName.hashCode ^
        timeSlot.hashCode;
  }
}

class BookingStatus {
  static const String confirmed = "Confirmed";
  static const String pending = "Pending";
}
