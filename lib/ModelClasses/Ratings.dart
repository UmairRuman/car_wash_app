// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ratings {
  String serviceId;
  String serviceName;
  String userId;
  double rating;
  String userName;
  bool isServiceRated;

  Ratings({
    required this.serviceId,
    required this.serviceName,
    required this.userId,
    required this.rating,
    required this.userName,
    required this.isServiceRated,
  });

  Ratings copyWith({
    String? serviceId,
    String? serviceName,
    String? userId,
    double? rating,
    String? userName,
    bool? isServiceRated,
  }) {
    return Ratings(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      userName: userName ?? this.userName,
      isServiceRated: isServiceRated ?? this.isServiceRated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'serviceName': serviceName,
      'userId': userId,
      'rating': rating,
      'userName': userName,
      'isServiceRated': isServiceRated,
    };
  }

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      serviceId: map['serviceId'] as String,
      serviceName: map['serviceName'] as String,
      userId: map['userId'] as String,
      rating: map['rating'] as double,
      userName: map['userName'] as String,
      isServiceRated: map['isServiceRated'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratings.fromJson(String source) =>
      Ratings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ratings(serviceId: $serviceId, serviceName: $serviceName, userId: $userId, rating: $rating, userName: $userName, isServiceRated: $isServiceRated)';
  }

  @override
  bool operator ==(covariant Ratings other) {
    if (identical(this, other)) return true;

    return other.serviceId == serviceId &&
        other.serviceName == serviceName &&
        other.userId == userId &&
        other.rating == rating &&
        other.userName == userName &&
        other.isServiceRated == isServiceRated;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        serviceName.hashCode ^
        userId.hashCode ^
        rating.hashCode ^
        userName.hashCode ^
        isServiceRated.hashCode;
  }
}
