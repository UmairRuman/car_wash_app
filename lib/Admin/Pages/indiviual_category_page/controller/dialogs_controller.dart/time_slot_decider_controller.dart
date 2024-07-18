import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSlotDeciderController extends Notifier<String> {
  String intialStartTime = "";
  String intialEndTime = "";
  int startIndex = 0;
  int endIndex = 0;
  bool isStartTimeChanged = false;
  bool isEndTimeChanged = false;
  @override
  String build() {
    return intialEndTime;
  }

  onStartTimeChange(Time newStarttime) {
    if (newStarttime.hour >= 0 && newStarttime.hour <= 12) {
      intialStartTime = "${newStarttime.hour}:${newStarttime.minute} am";
      isStartTimeChanged = true;
    } else {
      intialStartTime = "${newStarttime.hour}:${newStarttime.minute} pm";
      isStartTimeChanged = true;
    }
  }

  onEndTimeChange(Time newEndTime) {
    if (newEndTime.hour >= 13 && newEndTime.hour <= 24) {
      isEndTimeChanged = true;
      var timeIn12 = newEndTime.hour % 12;
      intialEndTime = "$timeIn12:${newEndTime.minute} pm";
    } else {
      isEndTimeChanged = true;
      var timeIn12 = newEndTime.hour % 12;
      intialEndTime = "$timeIn12:${newEndTime.minute} am";
    }
  }

  onSaveButtonClick() {
    if (isEndTimeChanged || isStartTimeChanged) {
      state = "changed";
    }
  }

  findStartIndex(int newStartIndex) {
    startIndex = newStartIndex;
  }

  findEndIndex(int newEndIndex) {
    endIndex = newEndIndex;
  }
}

final timeSlotTimingStateProvider =
    NotifierProvider<TimeSlotDeciderController, String>(
        TimeSlotDeciderController.new);
