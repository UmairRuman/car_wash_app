import 'package:flutter_riverpod/flutter_riverpod.dart';

class YearController extends Notifier<int> {
  int intialYear = DateTime.now().year;
  @override
  int build() {
    return intialYear;
  }

  onChangeYear(int newYear) {
    state = newYear;
  }
}

final yearStateProvider =
    NotifierProvider<YearController, int>(YearController.new);
