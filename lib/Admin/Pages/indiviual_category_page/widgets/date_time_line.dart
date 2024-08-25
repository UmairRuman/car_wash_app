import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/incrementing_days_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/year_controller.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/controller/date_time_controller.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideDateTimePicker extends ConsumerWidget {
  final String serviceName;
  final String serviceId;
  const AdminSideDateTimePicker(
      {super.key, required this.serviceId, required this.serviceName});

  List<DateTime> getInactiveDates() {
    List<DateTime> inactiveDates = [];
    DateTime startDate = DateTime.now();
    // Check the next 7 days
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      // If it's a Sunday, add it to the inactive dates list
      if (currentDate.weekday == DateTime.sunday) {
        inactiveDates.add(currentDate);
      }
    }
    return inactiveDates;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime focusDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var selectedYear = ref.watch(yearStateProvider);
    return DatePicker(
      // inactiveDates: getInactiveDates(),
      daysCount:
          ref.read(increamentingDaysStateProvider.notifier).intialShowingDates,
      initialSelectedDate: DateTime.now(),
      DateTime.now(),
      selectionColor: Colors.blue,
      selectedTextColor: Colors.white,
      onDateChange: (selectedDate) {
        //We are setting current Date  to delete TimeSlots at that date
        ref.read(timeSlotsStateProvider.notifier).currentDate =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        ref.read(timeSlotsStateProvider.notifier).getTimeSlots(
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
            );
        focusDate =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        ref.read(dateProvider.notifier).onClickChangeDate(
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
      },
    );
  }
}
