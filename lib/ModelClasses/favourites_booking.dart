// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavouriteSerivces {
  int favouriteServiceId;
  String serviceName;
  String userId;
  double serviceRating;
  String serviceImageUrl;
  double servicePrice;
  FavouriteSerivces({
    required this.favouriteServiceId,
    required this.serviceName,
    required this.userId,
    required this.serviceRating,
    required this.serviceImageUrl,
    required this.servicePrice,
  });

  FavouriteSerivces copyWith({
    int? favouriteServiceId,
    String? serviceName,
    String? userId,
    double? serviceRating,
    String? serviceImageUrl,
    double? servicePrice,
  }) {
    return FavouriteSerivces(
      favouriteServiceId: favouriteServiceId ?? this.favouriteServiceId,
      serviceName: serviceName ?? this.serviceName,
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
      'userId': userId,
      'serviceRating': serviceRating,
      'serviceImageUrl': serviceImageUrl,
      'servicePrice': servicePrice,
    };
  }

  factory FavouriteSerivces.fromMap(Map<String, dynamic> map) {
    return FavouriteSerivces(
      favouriteServiceId: map['favouriteServiceId'] as int,
      serviceName: map['serviceName'] as String,
      userId: map['userId'] as String,
      serviceRating: map['serviceRating'] as double,
      serviceImageUrl: map['serviceImageUrl'] as String,
      servicePrice: map['servicePrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteSerivces.fromJson(String source) =>
      FavouriteSerivces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavouriteSerivces(favouriteServiceId: $favouriteServiceId, serviceName: $serviceName, userId: $userId, serviceRating: $serviceRating, serviceImageUrl: $serviceImageUrl, servicePrice: $servicePrice)';
  }

  @override
  bool operator ==(covariant FavouriteSerivces other) {
    if (identical(this, other)) return true;

    return other.favouriteServiceId == favouriteServiceId &&
        other.serviceName == serviceName &&
        other.userId == userId &&
        other.serviceRating == serviceRating &&
        other.serviceImageUrl == serviceImageUrl &&
        other.servicePrice == servicePrice;
  }

  @override
  int get hashCode {
    return favouriteServiceId.hashCode ^
        serviceName.hashCode ^
        userId.hashCode ^
        serviceRating.hashCode ^
        serviceImageUrl.hashCode ^
        servicePrice.hashCode;
  }
}
