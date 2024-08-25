import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/car_service_counter.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceAdditionController extends Notifier<ServiceDataStates> {
  String? adminId = prefs!.getString(SharedPreferncesConstants.adminkey) ??
      FirebaseAuth.instance.currentUser!.uid;
  String iconUrl = "";
  ServiceCollection serviceCollection = ServiceCollection();
  FavouriteServicesCounterCollection favouriteServicesCounterCollection =
      FavouriteServicesCounterCollection();
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

  Future<void> onSaveBtnClick() async {
    log("Icon Url  : $iconUrl");
    String userId = FirebaseAuth.instance.currentUser!.uid;
    //Getting all service count

    String serviceId = await serviceCollection.getLastServiceId(adminId!);
    log("Service Id $serviceId");
    if (int.parse(serviceId) < 9) {
      serviceId = "0${int.parse(serviceId) + 1}";
    } else if (serviceId == "") {
      serviceId = "01";
    } else {
      serviceId = "${int.parse(serviceId) + 1}";
    }
    log("Service Id $serviceId");
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
      log("Icon URl in adding service : $iconUrl");
      log("Adding service");
      //Adding plus one in the counter collection

      serviceCollection.addNewService(Services(
          rating: 5,
          isAssetImage: false,
          serviceId: serviceId,
          adminId: adminId!,
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

  Future<void> deleteSpecificService(
      String serviceName, String serviceId) async {
    try {
      await serviceCollection.deleteSpecificService(
          adminId!, serviceName, serviceId);

      await fetchAllDataFromFireStore();
    } catch (e) {
      log("Failed in deleting Specific Service");
    }
  }

  fetchAllDataFromFireStore() async {
    state = ServiceDataLoadingState();
    try {
      var listOfServices =
          await serviceCollection.getAllServicesByAdmin(adminId!);
      state = ServiceDataLoadedState(services: listOfServices);
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
