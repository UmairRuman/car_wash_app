import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/car_service_counter.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    List<ServiceCounter> listOfServices = await serviceCounterCollection
        .getAllServiceCount(FirebaseAuth.instance.currentUser!.uid);

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
          ServiceCounter(count: listOfServices.length + 1),
          FirebaseAuth.instance.currentUser!.uid);

      serviceCollection.addNewService(Services(
          serviceId: listOfServices.length + 1,
          adminId: FirebaseAuth.instance.currentUser!.uid,
          serviceName: serviecNameTEC.text,
          description: "No Description",
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
    state = ServiceDataLoadingState();
    try {
      var listOfServices = await serviceCollection
          .getAllServicesByAdmin(FirebaseAuth.instance.currentUser!.uid);
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
