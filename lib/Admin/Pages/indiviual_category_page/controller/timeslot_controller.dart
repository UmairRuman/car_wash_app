import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeslotController extends Notifier<TimeSlotStates> {
  TimeSlotCollection timeSlotCollection = TimeSlotCollection();
  @override
  TimeSlotStates build() {
    return TimeSlotInitialState();
  }

  void getTimeSlots(
      DateTime dateTime, int serviceId, String serviceName) async {
    state = TimeSlotLoadingState();
    log("Loading state");
    try {
      var timeSlots = await timeSlotCollection.getSpecificDateSlots(
          FirebaseAuth.instance.currentUser!.uid,
          serviceId,
          serviceName,
          dateTime);

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
