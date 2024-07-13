import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSlotInfoController extends Notifier<DateTime> {
  var initialTime = DateTime.now();
  @override
  DateTime build() {
    return initialTime;
  }

  onChangeTimeSlot(DateTime selectedTime) {
    state = selectedTime;
  }
}

final timeSlotProvider = NotifierProvider<TimeSlotInfoController, DateTime>(
    TimeSlotInfoController.new);
