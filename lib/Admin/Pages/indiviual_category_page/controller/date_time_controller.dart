import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimeController extends Notifier<DateTime> {
  DateTime focusDate = DateTime.now();
  @override
  DateTime build() {
    return focusDate;
  }

  onClickChangeDate(DateTime selectedDateTime) {
    state = selectedDateTime;
    focusDate = selectedDateTime;
  }
}

final dateProvider =
    NotifierProvider<DateTimeController, DateTime>(DateTimeController.new);
