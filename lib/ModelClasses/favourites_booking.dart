// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteServices {
  String favouriteServiceId;
  String serviceName;
  DateTime createdAt;
  String userId;
  double serviceRating;
  String serviceImageUrl;
  double servicePrice;
  FavouriteServices({
    required this.favouriteServiceId,
    required this.serviceName,
    required this.createdAt,
    required this.userId,
    required this.serviceRating,
    required this.serviceImageUrl,
    required this.servicePrice,
  });

  FavouriteServices copyWith({
    String? favouriteServiceId,
    String? serviceName,
    DateTime? createdAt,
    String? userId,
    double? serviceRating,
    String? serviceImageUrl,
    double? servicePrice,
  }) {
    return FavouriteServices(
      favouriteServiceId: favouriteServiceId ?? this.favouriteServiceId,
      serviceName: serviceName ?? this.serviceName,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      serviceRating: serviceRating ?? this.serviceRating,
      serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
      servicePrice: servicePrice ?? this.servicePrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favouriteServiceId': favouriteServiceId,
      'serviceName': serviceName,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
      'serviceRating': serviceRating,
      'serviceImageUrl': serviceImageUrl,
      'servicePrice': servicePrice,
    };
  }

  factory FavouriteServices.fromMap(Map<String, dynamic> map) {
    return FavouriteServices(
      favouriteServiceId: map['favouriteServiceId'] as String,
      serviceName: map['serviceName'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      userId: map['userId'] as String,
      serviceRating: map['serviceRating'] as double,
      serviceImageUrl: map['serviceImageUrl'] as String,
      servicePrice: map['servicePrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteServices.fromJson(String source) =>
      FavouriteServices.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavouriteServices(favouriteServiceId: $favouriteServiceId, serviceName: $serviceName, createdAt: $createdAt, userId: $userId, serviceRating: $serviceRating, serviceImageUrl: $serviceImageUrl, servicePrice: $servicePrice)';
  }

  @override
  bool operator ==(covariant FavouriteServices other) {
    if (identical(this, other)) return true;

    return other.favouriteServiceId == favouriteServiceId &&
        other.serviceName == serviceName &&
        other.createdAt == createdAt &&
        other.userId == userId &&
        other.serviceRating == serviceRating &&
        other.serviceImageUrl == serviceImageUrl &&
        other.servicePrice == servicePrice;
  }

  @override
  int get hashCode {
    return favouriteServiceId.hashCode ^
        serviceName.hashCode ^
        createdAt.hashCode ^
        userId.hashCode ^
        serviceRating.hashCode ^
        serviceImageUrl.hashCode ^
        servicePrice.hashCode;
  }
}
