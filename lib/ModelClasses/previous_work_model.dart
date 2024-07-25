// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousWorkModel {
  String previousWorkImage;
  String serviceName;
  double serviceRating;
  DateTime serviceProvideTime;
  String id;
  bool isAssetImage;
  PreviousWorkModel({
    required this.previousWorkImage,
    required this.serviceName,
    required this.serviceRating,
    required this.serviceProvideTime,
    required this.id,
    required this.isAssetImage,
  });

  PreviousWorkModel copyWith({
    String? previousWorkImage,
    String? serviceName,
    double? serviceRating,
    DateTime? serviceProvideTime,
    String? id,
    bool? isAssetImage,
  }) {
    return PreviousWorkModel(
      previousWorkImage: previousWorkImage ?? this.previousWorkImage,
      serviceName: serviceName ?? this.serviceName,
      serviceRating: serviceRating ?? this.serviceRating,
      serviceProvideTime: serviceProvideTime ?? this.serviceProvideTime,
      id: id ?? this.id,
      isAssetImage: isAssetImage ?? this.isAssetImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'previousWorkImage': previousWorkImage,
      'serviceName': serviceName,
      'serviceRating': serviceRating,
      'serviceProvideTime': Timestamp.fromDate(serviceProvideTime),
      'id': id,
      'isAssetImage': isAssetImage,
    };
  }

  factory PreviousWorkModel.fromMap(Map<String, dynamic> map) {
    return PreviousWorkModel(
      previousWorkImage: map['previousWorkImage'] as String,
      serviceName: map['serviceName'] as String,
      serviceRating: map['serviceRating'] as double,
      serviceProvideTime: (map['serviceProvideTime'] as Timestamp).toDate(),
      id: map['id'] as String,
      isAssetImage: map['isAssetImage'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviousWorkModel.fromJson(String source) =>
      PreviousWorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PreviousWorkModel(previousWorkImage: $previousWorkImage, serviceName: $serviceName, serviceRating: $serviceRating, serviceProvideTime: $serviceProvideTime, id: $id, isAssetImage: $isAssetImage)';
  }

  @override
  bool operator ==(covariant PreviousWorkModel other) {
    if (identical(this, other)) return true;

    return other.previousWorkImage == previousWorkImage &&
        other.serviceName == serviceName &&
        other.serviceRating == serviceRating &&
        other.serviceProvideTime == serviceProvideTime &&
        other.id == id &&
        other.isAssetImage == isAssetImage;
  }

  @override
  int get hashCode {
    return previousWorkImage.hashCode ^
        serviceName.hashCode ^
        serviceRating.hashCode ^
        serviceProvideTime.hashCode ^
        id.hashCode ^
        isAssetImage.hashCode;
  }
}
