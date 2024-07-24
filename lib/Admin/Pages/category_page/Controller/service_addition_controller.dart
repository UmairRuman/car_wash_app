import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/car_service_counter.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/favourite_service_counter.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceAdditionController extends Notifier<ServiceDataStates> {
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

  onSaveBtnClick() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? adminId = prefs!.getString(SharedPreferncesConstants.adminkey);
    List<ServiceCounter> listOfServices =
        await serviceCounterCollection.getAllServiceCount(adminId!);
    log("List length : ${listOfServices.length}");
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

    var favouriteServiceCount = await favouriteServicesCounterCollection
        .getAllUserBookingsCount(userId);
    var favouriteServiceIdCount = favouriteServiceCount.length + 1;
    var favouriteServiceId = "$favouriteServiceIdCount";
    if (favouriteServiceIdCount < 10) {
      favouriteServiceId = "0$favouriteServiceIdCount";
    }

    if (isIconPicked) {
      log("Adding service");
      //Adding plus one in the counter collection
      serviceCounterCollection.addCount(
          ServiceCounter(count: listOfServices.length + 1), adminId);

      serviceCollection.addNewService(Services(
          serviceFavouriteId: favouriteServiceId,
          rating: 5,
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
    var adminId = prefs!.getString(SharedPreferncesConstants.adminkey);

    state = ServiceDataLoadingState();
    try {
      var listOfServices =
          await serviceCollection.getAllServicesByAdmin(adminId!);
      state = ServiceDataLoadedState(services: listOfServices);
      log("List of services length : ${listOfServices.length}");
      log("Is asset Icon : ${listOfServices[0].isAssetIcon}");
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
