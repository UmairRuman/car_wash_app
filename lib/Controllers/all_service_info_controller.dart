import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/car_info_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_info_controlller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/time_slot_decider_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_counter_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/time_slot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void addCars() async {
    cars = await serviceCollection
        .getAllCars(FirebaseAuth.instance.currentUser!.uid);
    log("CarInfo : ${cars[0].carName}");
    String carName = ref.read(carInfoProvider.notifier).carName;
    String carPrice =
        ref.read(carInfoProvider.notifier).carCurrentPrice.toString();
    String carPicUrl = ref.read(carInfoProvider.notifier).carImagePath;
    cars.add(
        Car(carName: carName, price: carPrice, url: carPicUrl, isAsset: false));
  }

  void updateService(int serviceId) async {
    // List<ServiceCounter> listOfServices = await serviceCounterCollection
    //     .getAllServiceCount(FirebaseAuth.instance.currentUser!.uid);

    // serviceId = listOfServices.length + 1;
    log("Service ID :  ${serviceId.toString()}");
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime endDate = DateTime(now.year, now.month + 1, now.day);

    var serviceDescription =
        ref.read(serviceInfoProvider.notifier).intialServiceDescription;
    String imageUrl = ref.read(serviceInfoProvider.notifier).imagePath;

    //List Of Dates and every date contain corresponding timeslots as selected by Admin
    List<DateTime> listOfDates = [];

    var startTime = ref.read(timeSlotTimingStateProvider.notifier).startIndex;
    var endTime = ref.read(timeSlotTimingStateProvider.notifier).endIndex;
    log("Start Time $startTime");
    log("End Time $endTime");
    //If the user is not null then we add a service collection in userId

    if (FirebaseAuth.instance.currentUser != null) {
      //Getting current user data
      String phoneNo = FirebaseAuth.instance.currentUser!.phoneNumber!;
      String adminId = FirebaseAuth.instance.currentUser!.uid;
      //Adding date in car list

      //Adding dates in date List

      for (DateTime date = now;
          date.isBefore(endDate);
          date = date.add(const Duration(days: 1))) {
        List<String> timeSlots = [];
        //Adding Time slots to specific Dates
        for (int startIndex = startTime; startIndex < endTime; startIndex++) {
          if (startIndex < 12) {
            timeSlots.add("$startIndex-${startIndex + 1}am");
          } else if (startIndex == 12) {
            timeSlots.add("$startIndex-${1}pm");
          } else {
            var twelveHourTime = startIndex % 12;
            timeSlots.add("$twelveHourTime-${twelveHourTime + 1}pm");
          }
        }
        timeSlotCollection.addTimeSlots(
            TimeSlots(
                serviceName: serviceName,
                currentDate: date,
                timeslots: timeSlots),
            adminId,
            serviceId);
        //Adding a new date in Date List
        listOfDates.add(date);
      }

      serviceCollection.updateNewService(Services(
          serviceId: serviceId,
          adminId: adminId,
          serviceName: serviceName,
          description: serviceDescription,
          iconUrl: iconUrl,
          isFavourite: false,
          cars: cars,
          imageUrl: imageUrl,
          availableDates: listOfDates,
          adminPhoneNo: phoneNo));
    }
  }

  void fetchServiceData(String serviceName, int serviceID) async {
    state = DataLoadingState();
    try {
      var service = await serviceCollection.getSpecificService(
          FirebaseAuth.instance.currentUser!.uid, serviceName, serviceID);
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
