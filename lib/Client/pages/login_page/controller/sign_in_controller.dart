import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController extends Notifier<String> {
  TextEditingController emailSignInTEC = TextEditingController();
  TextEditingController passwordSignInTEC = TextEditingController();
  @override
  String build() {
    ref.onDispose(
      () {
        emailSignInTEC.dispose();
        passwordSignInTEC.dispose();
      },
    );
    return "";
  }

  void clearSignInFields() {
    emailSignInTEC.clear();
    passwordSignInTEC.clear();
  }
}

final signInInfoProvider =
    NotifierProvider<SignInController, String>(SignInController.new);
