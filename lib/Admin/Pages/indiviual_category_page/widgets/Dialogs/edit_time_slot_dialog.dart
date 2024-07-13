import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/time_slot_decider_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSlotVariables {
  static TimeOfDay sunset = const TimeOfDay(hour: 12, minute: 0);
  static TimeOfDay sunrise = const TimeOfDay(hour: 8, minute: 0);
  static Time currentTime = Time(hour: 10, minute: 0);
}

void dialogForEditTimeSlot(
    BuildContext context, String serviceName, int serviceId) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) => Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    var startTime = ref
                        .read(timeSlotTimingStateProvider.notifier)
                        .intialStartTime;
                    var endTime = ref
                        .read(timeSlotTimingStateProvider.notifier)
                        .intialEndTime;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                Spacer(
                                  flex: 25,
                                ),
                                Expanded(
                                    flex: 40,
                                    child: FittedBox(
                                      child: Text(
                                        "Choose Time Slot",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Spacer(
                                  flex: 25,
                                )
                              ],
                            )),
                        Expanded(
                          flex: 50,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 50,
                                child: Column(
                                  children: [
                                    const Spacer(
                                      flex: 20,
                                    ),
                                    Expanded(
                                      flex: 40,
                                      child: FloatingActionButton(
                                        backgroundColor: Colors.amber,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            showPicker(
                                              context: context,
                                              value:
                                                  TimeSlotVariables.currentTime,
                                              sunrise: TimeSlotVariables
                                                  .sunrise, // optional
                                              sunset: TimeSlotVariables
                                                  .sunset, // optional
                                              duskSpanInMinutes:
                                                  120, // optional
                                              onChange: (selectedTime) {
                                                setState(() {
                                                  TimeSlotVariables
                                                          .currentTime =
                                                      selectedTime;
                                                  ref
                                                      .read(
                                                          timeSlotTimingStateProvider
                                                              .notifier)
                                                      .findStartIndex(
                                                          selectedTime.hour);
                                                  ref
                                                      .read(
                                                          timeSlotTimingStateProvider
                                                              .notifier)
                                                      .onStartTimeChange(
                                                          selectedTime);
                                                });
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Select",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 20,
                                    ),
                                    Expanded(
                                        flex: 20,
                                        child: FittedBox(
                                            child: Text(startTime == ""
                                                ? "Start time"
                                                : startTime)))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: Column(
                                  children: [
                                    const Spacer(
                                      flex: 20,
                                    ),
                                    Expanded(
                                      flex: 40,
                                      child: FloatingActionButton(
                                        backgroundColor: Colors.amber,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            showPicker(
                                              context: context,
                                              value:
                                                  TimeSlotVariables.currentTime,
                                              sunrise: TimeSlotVariables
                                                  .sunrise, // optional
                                              sunset: TimeSlotVariables
                                                  .sunset, // optional
                                              duskSpanInMinutes:
                                                  120, // optional
                                              onChange: (selectedTime) {
                                                setState(() {
                                                  ref
                                                      .read(
                                                          timeSlotTimingStateProvider
                                                              .notifier)
                                                      .findEndIndex(
                                                          selectedTime.hour);
                                                  TimeSlotVariables
                                                          .currentTime =
                                                      selectedTime;
                                                  ref
                                                      .read(
                                                          timeSlotTimingStateProvider
                                                              .notifier)
                                                      .onEndTimeChange(
                                                          selectedTime);
                                                });
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Select",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 20,
                                    ),
                                    Expanded(
                                        flex: 20,
                                        child: FittedBox(
                                            child: Text(endTime == ""
                                                ? "EndTime"
                                                : endTime)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Row(
                            children: [
                              const Spacer(
                                flex: 6,
                              ),
                              Expanded(
                                flex: 40,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  backgroundColor: const Color(0xFF1BC0C5),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Spacer(
                                flex: 8,
                              ),
                              Expanded(
                                flex: 40,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    ref
                                        .read(timeSlotsStateProvider.notifier)
                                        .getTimeSlots(
                                            DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                            ),
                                            serviceId,
                                            serviceName);
                                    Navigator.of(context).pop();
                                    ref
                                        .read(timeSlotTimingStateProvider
                                            .notifier)
                                        .onSaveButtonClick();
                                  },
                                  backgroundColor: const Color(0xFF1BC0C5),
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Spacer(
                                flex: 6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      });
}
