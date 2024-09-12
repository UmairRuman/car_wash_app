import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultServicesController extends Notifier<DefaultServicesStates> {
  FavouriteCollection favouriteCollection = FavouriteCollection();
  String? adminId = prefs!.getString(SharedPreferncesConstants.adminkey) == ""
      ? FirebaseAuth.instance.currentUser!.uid
      : prefs!.getString(SharedPreferncesConstants.adminkey);
  ServiceCollection serviceCollection = ServiceCollection();
  FavouriteServicesCounterCollection favouriteServicesCounterCollection =
      FavouriteServicesCounterCollection();
  ServiceCounterCollection serviceCounterCollection =
      ServiceCounterCollection();
  @override
  DefaultServicesStates build() {
    return DefaultServicesInitialState();
  }

  Future<void> addDefaultService() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    log("Current user id $userId");
    String adminPhoneNumber =
        FirebaseAuth.instance.currentUser!.phoneNumber == ""
            ? "No Phone no"
            : FirebaseAuth.instance.currentUser!.phoneNumber!;

    for (int index = 0; index < listOfCategoryIcons.length; index++) {
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
      List<Services> listOfServices =
          await serviceCollection.getAllServicesByAdmin(userId);
      var listLenght = listOfServices.length + 1;
      String serviceId;
      if (listLenght < 9) {
        serviceId = "0$listLenght";
      } else {
        serviceId = "$listLenght";
      }

      serviceCollection.addNewService(Services(
          rating: 5,
          isAssetImage: true,
          serviceId: serviceId,
          adminId: userId,
          serviceName: listOfCategoryName[index],
          description: "Click on Edit to add description",
          iconUrl: listOfCategoryIcons[index],
          cars: listOfCars,
          imageUrl: listOfPreviousWorkImages[index],
          availableDates: <DateTime>[],
          adminPhoneNo: adminPhoneNumber,
          isAssetIcon: true));
      await fetchingAllServicesFirstTime();
      // serviceCounterCollection.addCount(
      //     ServiceCounter(count: serviceId), userId!);
    }
  }

  fetchingAllServicesFirstTime() async {
    var adminId = prefs!.getString(SharedPreferncesConstants.adminkey);
    await Future.delayed(const Duration(seconds: 3));
    state = DefaultServicesLoadingState();
    try {
      var listOfServices =
          await serviceCollection.getAllServicesByAdmin(adminId!);
      state = DefaultServicesLoadedState(listOfServices: listOfServices);
      log("First Time List of services length : ${listOfServices.length}");
    } catch (e) {
      state = DefaultServicesErrorState(error: e.toString());
    }
  }
}

final defaultServicesStateProvider =
    NotifierProvider<DefaultServicesController, DefaultServicesStates>(
        DefaultServicesController.new);

abstract class DefaultServicesStates {}

class DefaultServicesInitialState extends DefaultServicesStates {}

class DefaultServicesLoadingState extends DefaultServicesStates {}

class DefaultServicesLoadedState extends DefaultServicesStates {
  final List<Services> listOfServices;
  DefaultServicesLoadedState({required this.listOfServices});
}

class DefaultServicesErrorState extends DefaultServicesStates {
  final String error;
  DefaultServicesErrorState({required this.error});
}
