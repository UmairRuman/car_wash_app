import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/time_slot_decider_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:car_wash_app/Functions/admin_info_function.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/ModelClasses/time_slot.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeslotController extends Notifier<TimeSlotStates> {
  TimeSlotCollection timeSlotCollection = TimeSlotCollection();
  List<DateTime> listOfDates = [];
  @override
  TimeSlotStates build() {
    return TimeSlotInitialState();
  }

  void addTimeSlots(int serviceId, String serviceName) {
    String adminId = prefs!.getString(ShraedPreferncesConstants.adminkey)!;
    var startTime = ref.read(timeSlotTimingStateProvider.notifier).startIndex;
    var endTime = ref.read(timeSlotTimingStateProvider.notifier).endIndex;
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime endDate = DateTime(now.year, now.month + 1, now.day);

    for (DateTime date = now;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 1))) {
      List<String> timeSlots = [];
      //Adding Time slots to specific Dates
      for (int startIndex = startTime; startIndex < endTime; startIndex++) {
        if (startIndex < 12) {
          timeSlots.add("$startIndex-${startIndex + 1}am");
        } else if (startIndex == 12) {
          timeSlots.add("$startIndex-${1}pm");
        } else {
          var twelveHourTime = startIndex % 12;
          timeSlots.add("$twelveHourTime-${twelveHourTime + 1}pm");
        }
      }
      timeSlotCollection.addTimeSlots(
          TimeSlots(
              serviceName: serviceName,
              currentDate: date,
              timeslots: timeSlots),
          adminId,
          serviceId);
      //Adding a new date in Date List
      listOfDates.add(date);
    }
  }

  void getTimeSlots(
      DateTime dateTime, int serviceId, String serviceName) async {
    String? adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);
    state = TimeSlotLoadingState();
    log("Loading state");
    try {
      var timeSlots = await timeSlotCollection.getSpecificDateSlots(
          adminId!, serviceId, serviceName, dateTime);

      if (timeSlots.isNotEmpty) {
        state = TimeSlotLoadedState(list: timeSlots);
        log("Loaded state with ${timeSlots.length} slots");
      } else {
        state = TimeSlotErrorState(
            error: "No time slots found for the selected date");
        log("No time slots found");
      }
    } catch (e) {
      state = TimeSlotErrorState(error: e.toString());
      log("Error state: $e");
    }
  }
}

final timeSlotsStateProvider =
    NotifierProvider<TimeslotController, TimeSlotStates>(
        TimeslotController.new);

abstract class TimeSlotStates {}

class TimeSlotInitialState extends TimeSlotStates {}

class TimeSlotLoadingState extends TimeSlotStates {}

class TimeSlotLoadedState extends TimeSlotStates {
  List<String> list;
  TimeSlotLoadedState({required this.list});
}

class TimeSlotErrorState extends TimeSlotStates {
  final String error;
  TimeSlotErrorState({required this.error});
}
