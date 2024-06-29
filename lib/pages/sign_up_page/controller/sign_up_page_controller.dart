import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPageController extends Notifier<String> {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

  @override
  String build() {
    return "";
  }

  void disposeControllers() {}
}

final signUpPageProvider =
    NotifierProvider<SignUpPageController, String>(SignUpPageController.new);
