// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PreviousServiceCounter {
  String count;
  PreviousServiceCounter({
    required this.count,
  });

  PreviousServiceCounter copyWith({
    String? count,
  }) {
    return PreviousServiceCounter(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
    };
  }

  factory PreviousServiceCounter.fromMap(Map<String, dynamic> map) {
    return PreviousServiceCounter(
      count: map['count'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviousServiceCounter.fromJson(String source) =>
      PreviousServiceCounter.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PreviousServiceCounter(count: $count)';

  @override
  bool operator ==(covariant PreviousServiceCounter other) {
    if (identical(this, other)) return true;

    return other.count == count;
  }

  @override
  int get hashCode => count.hashCode;
}
