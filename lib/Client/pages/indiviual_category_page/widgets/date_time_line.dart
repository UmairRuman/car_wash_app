import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/year_controller.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/controller/date_time_controller.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimePicker extends ConsumerWidget {
  final String serviceName;
  final String serviceId;
  const DateTimePicker(
      {super.key, required this.serviceId, required this.serviceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime focusDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var selectedYear = ref.watch(yearStateProvider);
    return DatePicker(
      daysCount: 7,
      DateTime(selectedYear, DateTime.now().month, DateTime.now().day),
      selectionColor: Colors.blue,
      selectedTextColor: Colors.white,
      onDateChange: (selectedDate) {
        log("Selected Date : ${DateTime(selectedDate.year, selectedDate.month, selectedDate.day)}");
        //Setting date for booking
        ref.read(bookingStateProvider.notifier).carWashDate =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        //For Getting time slot at specific date
        ref.read(timeSlotsStateProvider.notifier).getTimeSlots(
              DateTime(selectedYear, selectedDate.month, selectedDate.day),
            );

        focusDate =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        ref.read(dateProvider.notifier).onClickChangeDate(
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
      },
    );
  }
}
