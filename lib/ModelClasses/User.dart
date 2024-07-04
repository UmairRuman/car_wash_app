// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Users {
  String userId;
  String name;
  String email;
  String profilePicUrl;
  String phoneNumber;
  bool isServiceProvider;
  double bonusPoints;
  int serviceConsumed;
  DateTime createdAt;
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
  });

  Users copyWith({
    String? userId,
    String? name,
    String? email,
    String? profilePicUrl,
    String? phoneNumber,
    bool? isServiceProvider,
    double? bonusPoints,
    int? serviceConsumed,
    DateTime? createdAt,
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
      'createdAt': createdAt.millisecondsSinceEpoch,
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
      serviceConsumed: map['serviceConsumed'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(userId: $userId, name: $name, email: $email, profilePicUrl: $profilePicUrl, phoneNumber: $phoneNumber, isServiceProvider: $isServiceProvider, bonusPoints: $bonusPoints, serviceConsumed: $serviceConsumed, createdAt: $createdAt)';
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
        other.createdAt == createdAt;
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
        createdAt.hashCode;
  }
}
