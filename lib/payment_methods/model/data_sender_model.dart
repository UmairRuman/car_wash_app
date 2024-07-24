// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingPageDataSendingModel {
  String imagePath;
  String carName;
  String price;
  String timeSlot;
  DateTime dateTime;
  bool isCarAssetImage;
  String serviceName;
  String serviceImagePath;
  int serviceId;
  BookingPageDataSendingModel({
    required this.imagePath,
    required this.carName,
    required this.price,
    required this.timeSlot,
    required this.dateTime,
    required this.isCarAssetImage,
    required this.serviceName,
    required this.serviceImagePath,
    required this.serviceId,
  });

  BookingPageDataSendingModel copyWith({
    String? imagePath,
    String? carName,
    String? price,
    String? timeSlot,
    DateTime? dateTime,
    bool? isCarAssetImage,
    String? serviceName,
    String? serviceImagePath,
    int? serviceId,
  }) {
    return BookingPageDataSendingModel(
      imagePath: imagePath ?? this.imagePath,
      carName: carName ?? this.carName,
      price: price ?? this.price,
      timeSlot: timeSlot ?? this.timeSlot,
      dateTime: dateTime ?? this.dateTime,
      isCarAssetImage: isCarAssetImage ?? this.isCarAssetImage,
      serviceName: serviceName ?? this.serviceName,
      serviceImagePath: serviceImagePath ?? this.serviceImagePath,
      serviceId: serviceId ?? this.serviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'carName': carName,
      'price': price,
      'timeSlot': timeSlot,
      'dateTime': Timestamp.fromDate(dateTime),
      'isCarAssetImage': isCarAssetImage,
      'serviceName': serviceName,
      'serviceImagePath': serviceImagePath,
      'serviceId': serviceId,
    };
  }

  factory BookingPageDataSendingModel.fromMap(Map<String, dynamic> map) {
    return BookingPageDataSendingModel(
      imagePath: map['imagePath'] as String,
      carName: map['carName'] as String,
      price: map['price'] as String,
      timeSlot: map['timeSlot'] as String,
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      isCarAssetImage: map['isCarAssetImage'] as bool,
      serviceName: map['serviceName'] as String,
      serviceImagePath: map['serviceImagePath'] as String,
      serviceId: map['serviceId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingPageDataSendingModel.fromJson(String source) =>
      BookingPageDataSendingModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingPageDataSendingModel(imagePath: $imagePath, carName: $carName, price: $price, timeSlot: $timeSlot, dateTime: $dateTime, isCarAssetImage: $isCarAssetImage, serviceName: $serviceName, serviceImagePath: $serviceImagePath, serviceId: $serviceId)';
  }

  @override
  bool operator ==(covariant BookingPageDataSendingModel other) {
    if (identical(this, other)) return true;

    return other.imagePath == imagePath &&
        other.carName == carName &&
        other.price == price &&
        other.timeSlot == timeSlot &&
        other.dateTime == dateTime &&
        other.isCarAssetImage == isCarAssetImage &&
        other.serviceName == serviceName &&
        other.serviceImagePath == serviceImagePath &&
        other.serviceId == serviceId;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        carName.hashCode ^
        price.hashCode ^
        timeSlot.hashCode ^
        dateTime.hashCode ^
        isCarAssetImage.hashCode ^
        serviceName.hashCode ^
        serviceImagePath.hashCode ^
        serviceId.hashCode;
  }
}
