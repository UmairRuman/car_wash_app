import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceInfoControlller extends Notifier<String> {
  TextEditingController serviceDescriptionTEC = TextEditingController();
  String imagePath = "";
  TextEditingController phoneNoTEC = TextEditingController();
  String phoneNo = "Phone no";
  String intialServiceDescription = "No Description";
  @override
  String build() {
    return imagePath;
  }

  onChangeImagePath(String newImagePath) {
    state = newImagePath;
    imagePath = newImagePath;
    phoneNo = phoneNoTEC.text;
  }

  onChangeText(String serviceDescription) {
    intialServiceDescription = serviceDescription;
  }
}

final serviceInfoProvider = NotifierProvider<ServiceInfoControlller, String>(
    ServiceInfoControlller.new);
