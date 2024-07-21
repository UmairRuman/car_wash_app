import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/car_service_counter.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultServicesController extends Notifier<DefaultServicesStates> {
  ServiceCollection serviceCollection = ServiceCollection();
  FavouriteServicesCounterCollection favouriteServicesCounterCollection =
      FavouriteServicesCounterCollection();
  ServiceCounterCollection serviceCounterCollection =
      ServiceCounterCollection();
  @override
  DefaultServicesStates build() {
    return DefaultServicesInitialState();
  }

  addDefaultService() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);
    String? adminPhoneNumber =
        prefs!.getString(ShraedPreferncesConstants.phoneNo);

    for (int index = 0; index < listOfCategoryIcons.length; index++) {
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

      var favouriteServiceCount = await favouriteServicesCounterCollection
          .getAllUserBookingsCount(userId);
      var favouriteServiceIdCount = favouriteServiceCount.length + 1;
      var favouriteServiceId = "$favouriteServiceIdCount";
      if (favouriteServiceIdCount < 10) {
        favouriteServiceId = "0$favouriteServiceIdCount";
      }
      serviceCollection.addNewService(Services(
          serviceFavouriteId: favouriteServiceId,
          rating: 5,
          isAssetImage: true,
          serviceId: listOfServices.length,
          adminId: adminId,
          serviceName: listOfCategoryName[listOfServices.length],
          description: "Click on Edit to add description",
          iconUrl: listOfCategoryIcons[listOfServices.length],
          isFavourite: false,
          cars: listOfCars,
          imageUrl: listOfPreviousWorkImages[listOfServices.length],
          availableDates: <DateTime>[],
          adminPhoneNo: adminPhoneNumber!,
          isAssetIcon: true));

      serviceCounterCollection.addCount(
          ServiceCounter(count: listOfServices.length + 1), adminId);
    }
  }

  fetchingAllServicesFirstTime() async {
    var adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);

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
