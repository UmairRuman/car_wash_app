import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailTextProvider =
    NotifierProvider<EmailTextController, String>(EmailTextController.new);

class EmailTextController extends Notifier<String> {
  TextEditingController emailTEc = TextEditingController();
  @override
  String build() {
    ref.onDispose(
      () {
        emailTEc.dispose();
      },
    );
    return "";
  }

  onChangeEmailText() {
    state = emailTEc.text;
  }
}
