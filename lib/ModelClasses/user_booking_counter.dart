// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserBookingCounter {
  String userId;
  int count;
  UserBookingCounter({
    required this.userId,
    required this.count,
  });

  UserBookingCounter copyWith({
    String? userId,
    int? count,
  }) {
    return UserBookingCounter(
      userId: userId ?? this.userId,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'count': count,
    };
  }

  factory UserBookingCounter.fromMap(Map<String, dynamic> map) {
    return UserBookingCounter(
      userId: map['userId'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBookingCounter.fromJson(String source) =>
      UserBookingCounter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserBookingCounter(userId: $userId, count: $count)';

  @override
  bool operator ==(covariant UserBookingCounter other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.count == count;
  }

  @override
  int get hashCode => userId.hashCode ^ count.hashCode;
}
