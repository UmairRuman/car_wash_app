import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceInfoControlller extends Notifier<String> {
  TextEditingController serviceDescriptionTEC = TextEditingController();
  String imagePath = "";
  String intialServiceDescription = "No Description";
  @override
  String build() {
    return imagePath;
  }

  onChangeImagePath(String newImagePath) {
    state = newImagePath;
  }

  onChangeText(String serviceDescription) {
    intialServiceDescription = serviceDescription;
  }
}

final serviceInfoProvider = NotifierProvider<ServiceInfoControlller, String>(
    ServiceInfoControlller.new);
