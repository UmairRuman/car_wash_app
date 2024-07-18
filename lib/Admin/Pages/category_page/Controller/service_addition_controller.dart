import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_info_function.dart';
import 'package:car_wash_app/ModelClasses/car_service_counter.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceAdditionController extends Notifier<ServiceDataStates> {
  String iconUrl = "";
  ServiceCollection serviceCollection = ServiceCollection();
  ServiceCounterCollection serviceCounterCollection =
      ServiceCounterCollection();
  TextEditingController serviecNameTEC = TextEditingController();
  String serviceName = "";
  bool isIconPicked = false;
  @override
  ServiceDataStates build() {
    ref.onDispose(
      () {
        serviecNameTEC.dispose();
      },
    );
    fetchAllDataFromFireStore();
    return ServiceDataIntialState();
  }

  void onChangeIconUrl(String newIconUrl) {
    iconUrl = newIconUrl;
  }

  onSaveBtnClick() async {
    String? adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);
    List<ServiceCounter> listOfServices =
        await serviceCounterCollection.getAllServiceCount(adminId!);
    List<Car> listOfCars = [];
    for (int index = 0; index < listOfCarImages.length; index++) {
      listOfCars.add(
        Car(
            carName: listofCarName[index],
            price: listOfCarWashPrices[index],
            url: listOfCarImages[index],
            isAsset: true),
      );
    }

    if (isIconPicked) {
      log("Adding service");
      //Adding plus one in the counter collection
      serviceCounterCollection.addCount(
          ServiceCounter(count: listOfServices.length + 1), adminId);

      serviceCollection.addNewService(Services(
          isAssetImage: false,
          serviceId: listOfServices.length + 1,
          adminId: adminId,
          isAssetIcon: false,
          serviceName: serviecNameTEC.text,
          description: "Click to add Description",
          iconUrl: iconUrl,
          isFavourite: false,
          cars: listOfCars,
          imageUrl: "",
          availableDates: <DateTime>[],
          adminPhoneNo: "No Phone Number"));

      await fetchAllDataFromFireStore();
    }
  }

  fetchAllDataFromFireStore() async {
    var adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);

    state = ServiceDataLoadingState();
    try {
      var listOfServices =
          await serviceCollection.getAllServicesByAdmin(adminId!);
      state = ServiceDataLoadedState(services: listOfServices);
      log("List of services length : ${listOfServices.length}");
    } catch (e) {
      state = ServiceDataErrorState(error: e.toString());
    }
  }
}

final serviceAddtionStateProvider =
    NotifierProvider<ServiceAdditionController, ServiceDataStates>(
        ServiceAdditionController.new);

class ServiceDataStates {}

class ServiceDataIntialState extends ServiceDataStates {}

class ServiceDataLoadingState extends ServiceDataStates {}

class ServiceDataLoadedState extends ServiceDataStates {
  List<Services> services;
  ServiceDataLoadedState({required this.services});
}

class ServiceDataErrorState extends ServiceDataStates {
  final String error;
  ServiceDataErrorState({required this.error});
}
