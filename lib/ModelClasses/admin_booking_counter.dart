// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavouriteServiceCounter {
  String userId;
  String count;
  FavouriteServiceCounter({
    required this.userId,
    required this.count,
  });

  FavouriteServiceCounter copyWith({
    String? userId,
    String? count,
  }) {
    return FavouriteServiceCounter(
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

  factory FavouriteServiceCounter.fromMap(Map<String, dynamic> map) {
    return FavouriteServiceCounter(
      userId: map['userId'] as String,
      count: map['count'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteServiceCounter.fromJson(String source) =>
      FavouriteServiceCounter.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavouriteServicesCounter(userId: $userId, count: $count)';

  @override
  bool operator ==(covariant FavouriteServiceCounter other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.count == count;
  }

  @override
  int get hashCode => userId.hashCode ^ count.hashCode;
}
