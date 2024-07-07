import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SquareColorController extends Notifier<Color> {
  Color customerBoxColor = Colors.blue;
  Color customerTextColor = Colors.white;
  Color attendentBoxColor = const Color.fromARGB(255, 241, 240, 240);
  Color attendentTextColor = Colors.black;
  @override
  Color build() {
    return customerBoxColor;
  }

  onClickOnAttendentChoice() {
    state = const Color.fromARGB(255, 241, 240, 240);
    customerTextColor = Colors.black;
    attendentBoxColor = Colors.blue;
    attendentTextColor = Colors.white;
  }

  onClickOnCustomerChoice() {
    state = Colors.blue;
    customerTextColor = Colors.white;
    attendentBoxColor = const Color.fromARGB(255, 241, 240, 240);
    attendentTextColor = Colors.black;
  }
}

final colorNotifierProvider =
    NotifierProvider<SquareColorController, Color>(SquareColorController.new);
