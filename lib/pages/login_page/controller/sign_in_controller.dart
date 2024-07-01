import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController extends Notifier<String> {
  TextEditingController emailSignInTEC = TextEditingController();
  TextEditingController passwordSignInTEC = TextEditingController();
  @override
  String build() {
    return "";
  }
}

final signInInfoProvider =
    NotifierProvider<SignInController, String>(SignInController.new);
