// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminDeviceTokens {
  String deviceToken;
  String adminNo;
  String adminId;
  AdminDeviceTokens({
    required this.deviceToken,
    required this.adminNo,
    required this.adminId,
  });

  AdminDeviceTokens copyWith({
    String? deviceToken,
    String? adminNo,
    String? adminId,
  }) {
    return AdminDeviceTokens(
      deviceToken: deviceToken ?? this.deviceToken,
      adminNo: adminNo ?? this.adminNo,
      adminId: adminId ?? this.adminId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceToken': deviceToken,
      'adminNo': adminNo,
      'adminId': adminId,
    };
  }

  factory AdminDeviceTokens.fromMap(Map<String, dynamic> map) {
    return AdminDeviceTokens(
      deviceToken: map['deviceToken'] as String,
      adminNo: map['adminNo'] as String,
      adminId: map['adminId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminDeviceTokens.fromJson(String source) =>
      AdminDeviceTokens.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AdminDeviceTokens(deviceToken: $deviceToken, adminNo: $adminNo, adminId: $adminId)';

  @override
  bool operator ==(covariant AdminDeviceTokens other) {
    if (identical(this, other)) return true;

    return other.deviceToken == deviceToken &&
        other.adminNo == adminNo &&
        other.adminId == adminId;
  }

  @override
  int get hashCode =>
      deviceToken.hashCode ^ adminNo.hashCode ^ adminId.hashCode;
}
