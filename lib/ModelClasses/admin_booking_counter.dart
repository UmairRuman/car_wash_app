// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminServiceCounter {
  String userId;
  String count;
  AdminServiceCounter({
    required this.userId,
    required this.count,
  });

  AdminServiceCounter copyWith({
    String? userId,
    String? count,
  }) {
    return AdminServiceCounter(
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

  factory AdminServiceCounter.fromMap(Map<String, dynamic> map) {
    return AdminServiceCounter(
      userId: map['userId'] as String,
      count: map['count'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminServiceCounter.fromJson(String source) =>
      AdminServiceCounter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavouriteServicesCounter(userId: $userId, count: $count)';

  @override
  bool operator ==(covariant AdminServiceCounter other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.count == count;
  }

  @override
  int get hashCode => userId.hashCode ^ count.hashCode;
}
