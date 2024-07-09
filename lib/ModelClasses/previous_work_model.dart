// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PreviousWorkModel {
  String previousWorkImage;
  String serviceName;
  num serviceRating;
  DateTime serviceProvideTime;
  int id;
  PreviousWorkModel({
    required this.previousWorkImage,
    required this.serviceName,
    required this.serviceRating,
    required this.serviceProvideTime,
    required this.id,
  });

  PreviousWorkModel copyWith({
    String? previousWorkImage,
    String? serviceName,
    num? serviceRating,
    DateTime? serviceProvideTime,
    int? id,
  }) {
    return PreviousWorkModel(
      previousWorkImage: previousWorkImage ?? this.previousWorkImage,
      serviceName: serviceName ?? this.serviceName,
      serviceRating: serviceRating ?? this.serviceRating,
      serviceProvideTime: serviceProvideTime ?? this.serviceProvideTime,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'previousWorkImage': previousWorkImage,
      'serviceName': serviceName,
      'serviceRating': serviceRating,
      'serviceProvideTime': serviceProvideTime.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory PreviousWorkModel.fromMap(Map<String, dynamic> map) {
    return PreviousWorkModel(
      previousWorkImage: map['previousWorkImage'] as String,
      serviceName: map['serviceName'] as String,
      serviceRating: map['serviceRating'] as num,
      serviceProvideTime:
          DateTime.fromMillisecondsSinceEpoch(map['serviceProvideTime'] as int),
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviousWorkModel.fromJson(String source) =>
      PreviousWorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PreviousWorkModel(previousWorkImage: $previousWorkImage, serviceName: $serviceName, serviceRating: $serviceRating, serviceProvideTime: $serviceProvideTime, id: $id)';
  }

  @override
  bool operator ==(covariant PreviousWorkModel other) {
    if (identical(this, other)) return true;

    return other.previousWorkImage == previousWorkImage &&
        other.serviceName == serviceName &&
        other.serviceRating == serviceRating &&
        other.serviceProvideTime == serviceProvideTime &&
        other.id == id;
  }

  @override
  int get hashCode {
    return previousWorkImage.hashCode ^
        serviceName.hashCode ^
        serviceRating.hashCode ^
        serviceProvideTime.hashCode ^
        id.hashCode;
  }
}
