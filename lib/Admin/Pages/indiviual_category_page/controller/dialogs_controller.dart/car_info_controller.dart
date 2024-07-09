import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarInfoController extends Notifier<String> {
  TextEditingController carNameTEC = TextEditingController();
  String carName = "Car name";
  String carImagePath = "";
  int carIntialPrice = 1;
  int carCurrentPrice = 0;
  bool isPickImage = false;
  bool isChangeCarName = false;
  bool isChangeCarPrice = false;
  @override
  String build() {
    return carName;
  }

  onChangeCarPic(String newCarImagePath) {
    carImagePath = newCarImagePath;
  }

  onChangeCarName() {
    carName = carNameTEC.text;
    isChangeCarName = true;
  }

  onChangeCarPrice(int carNewPrice) {
    carCurrentPrice = carNewPrice;
  }

  onSaveButtonClick() {
    if (isPickImage && isChangeCarName && isChangeCarPrice) {
      state = "Changed";
    }
  }
}

final carInfoProvider =
    NotifierProvider<CarInfoController, String>(CarInfoController.new);
