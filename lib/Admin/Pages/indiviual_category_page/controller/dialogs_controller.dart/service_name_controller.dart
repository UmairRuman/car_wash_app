import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceNameController extends Notifier<String> {
  TextEditingController serviceNameTEC = TextEditingController();
  String serviceTitle = "Not Title";
  @override
  String build() {
    return serviceTitle;
  }

  onchangeTitle(String changeTitle) {
    state = changeTitle;
  }
}

final serviceNameProvider =
    NotifierProvider<ServiceNameController, String>(ServiceNameController.new);
