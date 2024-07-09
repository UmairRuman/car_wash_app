// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Timeslot {
  String serviceId;
  String currentDate;
  List<TimeSlotsInfo> timeslots;
  Timeslot({
    required this.serviceId,
    required this.currentDate,
    required this.timeslots,
  });

  Timeslot copyWith({
    String? serviceId,
    String? currentDate,
    List<TimeSlotsInfo>? timeslots,
  }) {
    return Timeslot(
      serviceId: serviceId ?? this.serviceId,
      currentDate: currentDate ?? this.currentDate,
      timeslots: timeslots ?? this.timeslots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'currentDate': currentDate,
      'timeslots': timeslots.map((x) => x.toMap()).toList(),
    };
  }

  factory Timeslot.fromMap(Map<String, dynamic> map) {
    return Timeslot(
      serviceId: map['serviceId'] as String,
      currentDate: map['currentDate'] as String,
      timeslots: List<TimeSlotsInfo>.from(
        (map['timeslots'] as List<int>).map<TimeSlotsInfo>(
          (x) => TimeSlotsInfo.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Timeslot.fromJson(String source) =>
      Timeslot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Timeslot(serviceId: $serviceId, currentDate: $currentDate, timeslots: $timeslots)';

  @override
  bool operator ==(covariant Timeslot other) {
    if (identical(this, other)) return true;

    return other.serviceId == serviceId &&
        other.currentDate == currentDate &&
        listEquals(other.timeslots, timeslots);
  }

  @override
  int get hashCode =>
      serviceId.hashCode ^ currentDate.hashCode ^ timeslots.hashCode;
}

class TimeSlotsInfo {
  String startTime;
  String endTime;
  bool isBooked;
  TimeSlotsInfo({
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  TimeSlotsInfo copyWith({
    String? startTime,
    String? endTime,
    bool? isBooked,
  }) {
    return TimeSlotsInfo(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isBooked: isBooked ?? this.isBooked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
      'isBooked': isBooked,
    };
  }

  factory TimeSlotsInfo.fromMap(Map<String, dynamic> map) {
    return TimeSlotsInfo(
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      isBooked: map['isBooked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeSlotsInfo.fromJson(String source) =>
      TimeSlotsInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TimeSlotsInfo(startTime: $startTime, endTime: $endTime, isBooked: $isBooked)';

  @override
  bool operator ==(covariant TimeSlotsInfo other) {
    if (identical(this, other)) return true;

    return other.startTime == startTime &&
        other.endTime == endTime &&
        other.isBooked == isBooked;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode ^ isBooked.hashCode;
}
