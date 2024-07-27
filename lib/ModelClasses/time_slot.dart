// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TimeSlots {
  DateTime currentDate;
  List<String> timeslots;
  TimeSlots({
    required this.currentDate,
    required this.timeslots,
  });

  TimeSlots copyWith({
    String? serviceName,
    DateTime? currentDate,
    List<String>? timeslots,
  }) {
    return TimeSlots(
      currentDate: currentDate ?? this.currentDate,
      timeslots: timeslots ?? this.timeslots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentDate': Timestamp.fromDate(currentDate),
      'timeslots': timeslots,
    };
  }

  factory TimeSlots.fromMap(Map<String, dynamic> map) {
    return TimeSlots(
      currentDate: (map['currentDate'] as Timestamp).toDate(),
      timeslots: List<String>.from((map['timeslots'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeSlots.fromJson(String source) =>
      TimeSlots.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TimeSlots(currentDate: $currentDate, timeslots: $timeslots)';

  @override
  bool operator ==(covariant TimeSlots other) {
    if (identical(this, other)) return true;

    return other.currentDate == currentDate &&
        listEquals(other.timeslots, timeslots);
  }

  @override
  int get hashCode => currentDate.hashCode ^ timeslots.hashCode;
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
