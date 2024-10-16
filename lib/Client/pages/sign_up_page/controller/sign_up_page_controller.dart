import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPageController extends Notifier<String> {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  bool isPhoneNoValidated = false;
  String combinePhoneNo = "";
  @override
  String build() {
    ref.onDispose(
      () {
        nameTEC.dispose();
        passwordTEC.dispose();
        emailTEC.dispose();
        phoneTEC.dispose();
      },
    );
    return "";
  }

  void clearAllSignUpFields() {
    nameTEC.clear();
    passwordTEC.clear();
    emailTEC.clear();
    phoneTEC.clear();
  }
}

final signUpPageProvider =
    NotifierProvider<SignUpPageController, String>(SignUpPageController.new);
