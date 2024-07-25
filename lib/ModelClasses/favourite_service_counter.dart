import 'dart:convert';

class FavouriteServiceCounter {
  String count;
  String userId;
  FavouriteServiceCounter({
    required this.count,
    required this.userId,
  });

  FavouriteServiceCounter copyWith({
    String? count,
    String? userId,
  }) {
    return FavouriteServiceCounter(
      count: count ?? this.count,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'userId': userId,
    };
  }

  factory FavouriteServiceCounter.fromMap(Map<String, dynamic> map) {
    return FavouriteServiceCounter(
      count: map['count'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteServiceCounter.fromJson(String source) =>
      FavouriteServiceCounter.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavouriteServiceCounter(count: $count, userId: $userId)';

  @override
  bool operator ==(covariant FavouriteServiceCounter other) {
    if (identical(this, other)) return true;

    return other.count == count && other.userId == userId;
  }

  @override
  int get hashCode => count.hashCode ^ userId.hashCode;
}
