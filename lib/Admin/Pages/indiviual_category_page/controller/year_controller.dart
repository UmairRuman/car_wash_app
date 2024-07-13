import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YearController extends Notifier<int> {
  int intialYear = DateTime.now().year;
  @override
  int build() {
    return intialYear;
  }

  onChangeYear(int newYear) {
    state = newYear;
    intialYear = newYear;
  }
}

final yearStateProvider =
    NotifierProvider<YearController, int>(YearController.new);
