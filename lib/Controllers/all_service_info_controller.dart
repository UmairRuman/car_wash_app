import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/car_info_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_info_controlller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/rating_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  final userKey = FirebaseAuth.instance.currentUser!.uid;
  ref.read(userAdditionStateProvider.notifier).getUser(userKey);
});

class AllServiceInfoController extends Notifier<DataStates> {
  RatingCollection ratingCollection = RatingCollection();
  var adminId = prefs!.getString(SharedPreferncesConstants.adminkey) == ""
      ? FirebaseAuth.instance.currentUser!.uid
      : prefs!.getString(SharedPreferncesConstants.adminkey);
  List<Services> intialListOfService = [];
  ServiceCollection serviceCollection = ServiceCollection();
  FavouriteCollection favouriteCollection = FavouriteCollection();
  FavouriteServicesCounterCollection favouriteServicesCounterCollection =
      FavouriteServicesCounterCollection();
  ServiceCounterCollection serviceCounterCollection =
      ServiceCounterCollection();
  TimeSlotCollection timeSlotCollection = TimeSlotCollection();
  String iconUrl = "";
  bool isFavourite = false;
  String carImageUrl = "";
  String serviceName = "";
  List<Car> listOfCars = [];

  @override
  DataStates build() {
    ref.onDispose(
      () {},
    );
    return DataIntialState();
  }

  Future<void> getIntialListOfServices() async {
    try {
      intialListOfService =
          await serviceCollection.getAllServicesByAdmin(adminId!);
    } catch (e) {
      log("Error in Getting intial service list ");
    }
  }

  void getServiceName(String name, String newiconUrl) {
    serviceName = name;
    iconUrl = newiconUrl;
  }

  //Method for Adding Cars

  Future<void> addCars(String serviceId, String serviceName) async {
    listOfCars = await serviceCollection.getAllCarsAtSpecificDocument(
        adminId!, serviceId, serviceName);

    String carName = ref.read(carInfoProvider.notifier).carName;
    String carPrice =
        ref.read(carInfoProvider.notifier).carCurrentPrice.toString();
    String carPicUrl = ref.read(carInfoProvider.notifier).carImagePath;

    if (carPicUrl != "" && carName != "" && carPrice != "") {
      log("Adding Car");
      Car car = Car(
          carName: carName,
          price: "$carPrice\$",
          url: carImageUrl,
          isAsset: false);
      await serviceCollection.updateCarList(
          adminId!, serviceId, serviceName, car);

      await fetchServiceData(serviceName, serviceId);
    }
    ref.read(carInfoProvider.notifier).carName = "";
    ref.read(carInfoProvider.notifier).carCurrentPrice = 1;
    ref.read(carInfoProvider.notifier).carImagePath = "";
  }

  //Method For deleting cars
  Future<void> deleteCar(
      int index, String serviceId, String serviceName) async {
    try {
      bool isCarRemoved = await serviceCollection.deleteCarFromList(
          adminId!, serviceId, serviceName, index);
      if (isCarRemoved) {
        await fetchServiceData(serviceName, serviceId);
      }
    } catch (e) {
      log("Error in deleting service");
    }
  }

  //Update Service

  Future<void> updateService(
      String serviceId, String serviceName, bool isFavourite) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var service = await serviceCollection.getSpecificService(
        adminId!, serviceName, serviceId);
    bool isAssetImage = false;
    bool isAssetIcon = false;

    await addCars(serviceId, serviceName);
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime endDate = DateTime(now.year, now.month + 1, now.day);

    var serviceDescription =
        ref.read(serviceInfoProvider.notifier).intialServiceDescription;

    String imageUrl = ref.read(serviceInfoProvider.notifier).imagePath;

    if (imageUrl == "") {
      imageUrl = service.imageUrl;
      isAssetImage = service.isAssetImage;
    }
    if (int.parse(service.serviceId) <= 7) {
      isAssetIcon = true;
    }

    //List Of Dates and every date contain corresponding timeslots as selected by Admin

    List<DateTime> listOfDates =
        ref.read(timeSlotsStateProvider.notifier).listOfDates;

    if (listOfDates == []) {
      listOfDates = service.availableDates;
    }

    //If the user is not null then we add a service collection in userId

    if (adminId != "") {
      //Getting current user data
      String? phoneNo = prefs!.getString(SharedPreferncesConstants.phoneNo);

      serviceCollection.updateNewService(Services(
          rating: 5,
          isAssetImage: isAssetImage,
          isAssetIcon: isAssetIcon,
          serviceId: serviceId,
          adminId: adminId!,
          serviceName: serviceName,
          description: serviceDescription,
          iconUrl: iconUrl,
          isFavourite: isFavourite,
          cars: listOfCars,
          imageUrl: imageUrl,
          availableDates: listOfDates,
          adminPhoneNo: phoneNo!));
      // favouriteServicesCounterCollection.addAdminBookingCount(
      //     FavouriteServiceCounter(count: favouriteServiceId, userId: userId));
    }
    await fetchServiceData(serviceName, serviceId);
  }

  Future<void> fetchServiceData(String serviceName, String serviceID) async {
    var adminId = prefs!.getString(SharedPreferncesConstants.adminkey);
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
