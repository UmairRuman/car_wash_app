// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminInfo {
  String adminName;
  String adminId;
  int adminNo;
  String adminPhoneNo;
  AdminInfo({
    required this.adminName,
    required this.adminId,
    required this.adminNo,
    required this.adminPhoneNo,
  });

  AdminInfo copyWith({
    String? adminName,
    String? adminId,
    int? adminNo,
    String? adminPhoneNo,
  }) {
    return AdminInfo(
      adminName: adminName ?? this.adminName,
      adminId: adminId ?? this.adminId,
      adminNo: adminNo ?? this.adminNo,
      adminPhoneNo: adminPhoneNo ?? this.adminPhoneNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adminName': adminName,
      'adminId': adminId,
      'adminNo': adminNo,
      'adminPhoneNo': adminPhoneNo,
    };
  }

  factory AdminInfo.fromMap(Map<String, dynamic> map) {
    return AdminInfo(
      adminName: map['adminName'] as String,
      adminId: map['adminId'] as String,
      adminNo: map['adminNo'] as int,
      adminPhoneNo: map['adminPhoneNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminInfo.fromJson(String source) =>
      AdminInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminInfo(adminName: $adminName, adminId: $adminId, adminNo: $adminNo, adminPhoneNo: $adminPhoneNo)';
  }

  @override
  bool operator ==(covariant AdminInfo other) {
    if (identical(this, other)) return true;

    return other.adminName == adminName &&
        other.adminId == adminId &&
        other.adminNo == adminNo &&
        other.adminPhoneNo == adminPhoneNo;
  }

  @override
  int get hashCode {
    return adminName.hashCode ^
        adminId.hashCode ^
        adminNo.hashCode ^
        adminPhoneNo.hashCode;
  }
}
