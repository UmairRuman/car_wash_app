import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carInfoUpdationProvider =
    NotifierProvider<CarInfoUpdationController, String>(
        CarInfoUpdationController.new);

class CarInfoUpdationController extends Notifier<String> {
  String newCarImagePath = "";
  TextEditingController carNameTEC = TextEditingController();

  @override
  String build() {
    ref.onDispose(
      () {
        carNameTEC.dispose();
      },
    );
    return "";
  }

  onChangeCarName(String oldName) {
    carNameTEC.text = oldName;
  }

  onChangeCarImagePath(String imagePath) {
    newCarImagePath = imagePath;
  }
}
