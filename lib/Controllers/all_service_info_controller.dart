import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/default_services_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/car_info_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_info_controlller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final adminkey =
      sharedPreferences.getString(ShraedPreferncesConstants.adminkey)!;

  ref.read(userAdditionStateProvider.notifier).getUser(adminkey);
  await ref
      .read(defaultServicesStateProvider.notifier)
      .fetchingAllServicesFirstTime();
});

class AllServiceInfoController extends Notifier<DataStates> {
  ServiceCollection serviceCollection = ServiceCollection();
  ServiceCounterCollection serviceCounterCollection =
      ServiceCounterCollection();
  TimeSlotCollection timeSlotCollection = TimeSlotCollection();
  String iconUrl = "";

  String serviceName = "";
  List<Car> cars = [];

  @override
  DataStates build() {
    return DataIntialState();
  }

  void getServiceName(String name, String newiconUrl) {
    serviceName = name;
    iconUrl = newiconUrl;
  }

  Future<void> addCars(int serviceId, String serviceName) async {
    var adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);
    cars = await serviceCollection.getAllCarsAtSpecificDocument(
        adminId!, serviceId, serviceName);
    // log("CarInfo : ${cars[0].carName}");
    String carName = ref.read(carInfoProvider.notifier).carName;
    String carPrice =
        ref.read(carInfoProvider.notifier).carCurrentPrice.toString();
    String carPicUrl = ref.read(carInfoProvider.notifier).carImagePath;
    if (carPicUrl != "" && carName != "" && carPrice != "") {
      log("Car added");
      cars.add(Car(
          carName: carName, price: carPrice, url: carPicUrl, isAsset: false));
    }
  }

  void updateService(int serviceId, String serviceName) async {
    var adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);
    var service = await serviceCollection.getSpecificService(
        adminId!, serviceName, serviceId);
    bool isAssetImage = false;
    bool isAssetIcon = false;

    await addCars(serviceId, serviceName);
    // var serviceData = await serviceCollection.getSpecificService(
    //     adminId!, serviceName, serviceId);

    // await addCars();
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime endDate = DateTime(now.year, now.month + 1, now.day);

    var serviceDescription =
        ref.read(serviceInfoProvider.notifier).intialServiceDescription;

    if (serviceDescription == "") {
      serviceDescription = service.description;
    }
    String imageUrl = ref.read(serviceInfoProvider.notifier).imagePath;

    if (imageUrl == "") {
      imageUrl = service.imageUrl;
      isAssetImage = service.isAssetImage;
    }
    if (service.serviceId <= 6) {
      isAssetIcon = true;
    }

    //List Of Dates and every date contain corresponding timeslots as selected by Admin

    List<DateTime> listOfDates =
        ref.read(timeSlotsStateProvider.notifier).listOfDates;

    if (listOfDates == []) {
      listOfDates = service.availableDates;
    }

    //If the user is not null then we add a service collection in userId

    if (adminId != null) {
      //Getting current user data
      String? phoneNo = prefs!.getString(ShraedPreferncesConstants.phoneNo);

      //Adding date in car list

      //Adding dates in date List

      serviceCollection.updateNewService(Services(
          isAssetImage: isAssetImage,
          isAssetIcon: isAssetIcon,
          serviceId: serviceId,
          adminId: adminId,
          serviceName: serviceName,
          description: serviceDescription,
          iconUrl: iconUrl,
          isFavourite: false,
          cars: cars,
          imageUrl: imageUrl,
          availableDates: listOfDates,
          adminPhoneNo: phoneNo!));
    }
  }

  Future<void> fetchServiceData(String serviceName, int serviceID) async {
    var adminId = prefs!.getString(ShraedPreferncesConstants.adminkey);
    log("admin Id in fetch services $adminId");
    state = DataLoadingState();
    try {
      var service = await serviceCollection.getSpecificService(
          adminId!, serviceName, serviceID);
      state = DataLoadedState(service: service);
    } catch (e) {
      state = DataErrorState(error: e.toString());
    }
  }
}

final allServiceDataStateProvider =
    NotifierProvider<AllServiceInfoController, DataStates>(
        AllServiceInfoController.new);

abstract class DataStates {}

class DataIntialState extends DataStates {}

class DataLoadingState extends DataStates {}

class DataLoadedState extends DataStates {
  Services service;
  DataLoadedState({required this.service});
}

class DataErrorState extends DataStates {
  final String error;
  DataErrorState({required this.error});
}
