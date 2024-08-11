import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keyStateProvider =
    NotifierProvider<KeyStateController, bool>(KeyStateController.new);

class KeyStateController extends Notifier<bool> {
  TextEditingController keyTEC = TextEditingController();
  @override
  bool build() {
    ref.onDispose(
      () {
        keyTEC.dispose();
      },
    );
    return false;
  }

  void onClickEnter() {
    state = true;
  }
}
