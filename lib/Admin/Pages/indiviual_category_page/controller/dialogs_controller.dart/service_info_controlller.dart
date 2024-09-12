import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceInfoControlller extends Notifier<String> {
  ServiceCollection serviceCollection = ServiceCollection();
  TextEditingController serviceDescriptionTEC = TextEditingController();
  String imagePath = "";
  TextEditingController phoneNoTEC = TextEditingController();
  String phoneNo = "Phone no";
  String intialServiceDescription = "No Description";
  @override
  String build() {
    return imagePath;
  }

  // onChangeImagePath(String newImagePath) {
  //   if (ServiceClassVariables.isImageModified) {
  //     state = newImagePath;
  //     imagePath = newImagePath;
  //     log("Image Path in Function $imagePath");
  //   }
  // }

  void previousServiceDescription(String serviceDescription) {
    serviceDescriptionTEC.text = serviceDescription;
  }

  Future<void> updateServiceImageAndDescription(
      String serviceName,
      String serviceDescription,
      String serviceId,
      String adminId,
      String imagePath,
      BuildContext context) async {
    try {
      await serviceCollection.updateServiceDescription(
          serviceDescription, serviceName, serviceId, adminId);
      await serviceCollection.updateServiceImagePath(
          imagePath, serviceName, serviceId, adminId);
      await ref
          .read(allServiceDataStateProvider.notifier)
          .fetchServiceData(serviceName, serviceId);
    } catch (e) {
      log("Error in Updating service Image and Description ");
    }
  }

  onChangeText(String serviceDescription) {
    intialServiceDescription = serviceDescription == ""
        ? intialServiceDescription
        : serviceDescription;
  }
}

final serviceInfoProvider = NotifierProvider<ServiceInfoControlller, String>(
    ServiceInfoControlller.new);
