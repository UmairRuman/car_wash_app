import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/year_controller.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/controller/date_time_controller.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimePicker extends ConsumerWidget {
  const DateTimePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentYear = ref.read(yearStateProvider.notifier).intialYear;
    return EasyInfiniteDateTimeLine(
        firstDate: DateTime(currentYear),
        activeColor: Colors.blue,
        selectionMode: const SelectionMode.autoCenter(),
        showTimelineHeader: false,
        focusDate: ref.read(dateProvider.notifier).focusDate,
        onDateChange: (selectedDate) {
          ref.read(dateProvider.notifier).onClickChangeDate(selectedDate);
        },
        lastDate: DateTime(currentYear, 12, 31));
  }
}
