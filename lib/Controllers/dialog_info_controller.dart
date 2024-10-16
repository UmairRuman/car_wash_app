import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dialogPhoneInfoProvider =
    NotifierProvider<DialogInfoController, String>(DialogInfoController.new);

class DialogInfoController extends Notifier<String> {
  TextEditingController phoneNoTEC = TextEditingController();
  bool isPhoneNoValidated = false;
  String combinePhoneNo = "";
  @override
  String build() {
    return "";
  }
}
