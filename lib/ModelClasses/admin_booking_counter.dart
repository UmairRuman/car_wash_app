// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavouriteServicesCounter {
  String userId;
  int count;
  FavouriteServicesCounter({
    required this.userId,
    required this.count,
  });

  FavouriteServicesCounter copyWith({
    String? adminId,
    int? count,
  }) {
    return FavouriteServicesCounter(
      userId: adminId ?? this.userId,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adminId': userId,
      'count': count,
    };
  }

  factory FavouriteServicesCounter.fromMap(Map<String, dynamic> map) {
    return FavouriteServicesCounter(
      userId: map['adminId'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteServicesCounter.fromJson(String source) =>
      FavouriteServicesCounter.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AdminBookingCounter(adminId: $userId, count: $count)';

  @override
  bool operator ==(covariant FavouriteServicesCounter other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.count == count;
  }

  @override
  int get hashCode => userId.hashCode ^ count.hashCode;
}
