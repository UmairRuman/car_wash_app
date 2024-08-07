// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminCounter {
  String count;
  AdminCounter({
    required this.count,
  });

  AdminCounter copyWith({
    String? count,
  }) {
    return AdminCounter(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
    };
  }

  factory AdminCounter.fromMap(Map<String, dynamic> map) {
    return AdminCounter(
      count: map['count'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminCounter.fromJson(String source) =>
      AdminCounter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AdminCount(count: $count)';

  @override
  bool operator ==(covariant AdminCounter other) {
    if (identical(this, other)) return true;

    return other.count == count;
  }

  @override
  int get hashCode => count.hashCode;
}
