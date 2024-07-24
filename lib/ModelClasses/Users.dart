// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String userId;
  String name;
  String email;
  String profilePicUrl;
  String phoneNumber;
  bool isServiceProvider;
  double bonusPoints;
  num serviceConsumed;
  DateTime createdAt;
  String userLocation;
  String deviceToken;
  Users({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicUrl,
    required this.phoneNumber,
    required this.isServiceProvider,
    required this.bonusPoints,
    required this.serviceConsumed,
    required this.createdAt,
    required this.userLocation,
    required this.deviceToken,
  });

  Users copyWith({
    String? userId,
    String? name,
    String? email,
    String? profilePicUrl,
    String? phoneNumber,
    bool? isServiceProvider,
    double? bonusPoints,
    num? serviceConsumed,
    DateTime? createdAt,
    String? userLocation,
    String? deviceToken,
  }) {
    return Users(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isServiceProvider: isServiceProvider ?? this.isServiceProvider,
      bonusPoints: bonusPoints ?? this.bonusPoints,
      serviceConsumed: serviceConsumed ?? this.serviceConsumed,
      createdAt: createdAt ?? this.createdAt,
      userLocation: userLocation ?? this.userLocation,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'phoneNumber': phoneNumber,
      'isServiceProvider': isServiceProvider,
      'bonusPoints': bonusPoints,
      'serviceConsumed': serviceConsumed,
      'createdAt': Timestamp.fromDate(createdAt),
      'userLocation': userLocation,
      'deviceToken': deviceToken,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePicUrl: map['profilePicUrl'] as String,
      phoneNumber: map['phoneNumber'] as String,
      isServiceProvider: map['isServiceProvider'] as bool,
      bonusPoints: map['bonusPoints'] as double,
      serviceConsumed: map['serviceConsumed'] as num,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      userLocation: map['userLocation'] as String,
      deviceToken: map['deviceToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(userId: $userId, name: $name, email: $email, profilePicUrl: $profilePicUrl, phoneNumber: $phoneNumber, isServiceProvider: $isServiceProvider, bonusPoints: $bonusPoints, serviceConsumed: $serviceConsumed, createdAt: $createdAt, userLocation: $userLocation, deviceToken: $deviceToken)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.profilePicUrl == profilePicUrl &&
        other.phoneNumber == phoneNumber &&
        other.isServiceProvider == isServiceProvider &&
        other.bonusPoints == bonusPoints &&
        other.serviceConsumed == serviceConsumed &&
        other.createdAt == createdAt &&
        other.userLocation == userLocation &&
        other.deviceToken == deviceToken;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profilePicUrl.hashCode ^
        phoneNumber.hashCode ^
        isServiceProvider.hashCode ^
        bonusPoints.hashCode ^
        serviceConsumed.hashCode ^
        createdAt.hashCode ^
        userLocation.hashCode ^
        deviceToken.hashCode;
  }
}
