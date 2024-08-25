import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoController extends Notifier<String> {
  TextEditingController carNameTEC = TextEditingController();
  String carName = "Car name";
  String carImagePath = "";
  int carIntialPrice = 1;
  int carCurrentPrice = 1;
  bool isPickImage = false;
  bool isChangeCarPrice = false;
  @override
  String build() {
    ref.onDispose(
      () {
        carNameTEC.dispose();
      },
    );
    return carName;
  }

  onChangeCarPic(String newCarImagePath) {
    carImagePath = newCarImagePath;
  }

  onChangeCarPrice(int carNewPrice) {
    carCurrentPrice = carNewPrice;
  }

  void onCancelButtonClick() {
    carImagePath = "";
    carNameTEC.text = "";
  }

  onSaveButtonClick() {
    carName = carNameTEC.text;
    if (isPickImage && isChangeCarPrice) {
      state = "Changed";
    } else {}
  }
}

final carInfoProvider =
    NotifierProvider<CarInfoController, String>(CarInfoController.new);
