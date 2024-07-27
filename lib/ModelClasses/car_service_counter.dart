// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServiceCounter {
  String count;
  ServiceCounter({
    required this.count,
  });

  ServiceCounter copyWith({
    String? count,
  }) {
    return ServiceCounter(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
    };
  }

  factory ServiceCounter.fromMap(Map<String, dynamic> map) {
    return ServiceCounter(
      count: map['count'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceCounter.fromJson(String source) =>
      ServiceCounter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ServiceCounter(count: $count)';

  @override
  bool operator ==(covariant ServiceCounter other) {
    if (identical(this, other)) return true;

    return other.count == count;
  }

  @override
  int get hashCode => count.hashCode;
}
