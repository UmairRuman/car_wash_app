// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminKey {
  String pin;
  AdminKey({
    required this.pin,
  });

  AdminKey copyWith({
    String? pin,
  }) {
    return AdminKey(
      pin: pin ?? this.pin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pin': pin,
    };
  }

  factory AdminKey.fromMap(Map<String, dynamic> map) {
    return AdminKey(
      pin: map['pin'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminKey.fromJson(String source) =>
      AdminKey.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AdminKey(pin: $pin)';

  @override
  bool operator ==(covariant AdminKey other) {
    if (identical(this, other)) return true;

    return other.pin == pin;
  }

  @override
  int get hashCode => pin.hashCode;
}
