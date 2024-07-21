import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/year_controller.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/controller/date_time_controller.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimePicker extends ConsumerWidget {
  final String serviceName;
  final int serviceId;
  const DateTimePicker(
      {super.key, required this.serviceId, required this.serviceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime focusDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var selectedYear = ref.watch(yearStateProvider);
    return EasyInfiniteDateTimeLine(
        firstDate:
            DateTime(selectedYear, DateTime.now().month, DateTime.now().day),
        activeColor: Colors.blue,
        selectionMode: const SelectionMode.autoCenter(),
        showTimelineHeader: false,
        focusDate: focusDate,
        onDateChange: (selectedDate) {
          log("Selected Date : ${DateTime(selectedDate.year, selectedDate.month, selectedDate.day)}");
          //Setting date for booking
          ref.read(bookingStateProvider.notifier).carWashDate =
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
          //For Getting time slot at specific date
          ref.read(timeSlotsStateProvider.notifier).getTimeSlots(
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
              serviceId,
              serviceName);

          focusDate =
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
          ref.read(dateProvider.notifier).onClickChangeDate(DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day));
        },
        lastDate: DateTime(
            selectedYear, DateTime.now().month + 1, DateTime.now().day));
  }
}
