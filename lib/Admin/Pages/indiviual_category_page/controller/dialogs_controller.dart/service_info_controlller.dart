import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_service_info.dart';
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
    if (ServiceClassVariables.isImageModified) {
      state = newImagePath;
      imagePath = newImagePath;
    }
    phoneNo = phoneNoTEC.text;
  }

  onChangeText(String serviceDescription) {
    intialServiceDescription = serviceDescription;
  }
}

final serviceInfoProvider = NotifierProvider<ServiceInfoControlller, String>(
    ServiceInfoControlller.new);
