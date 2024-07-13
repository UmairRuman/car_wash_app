import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/time_slot.dart';

class ServiceCollection {
  static final ServiceCollection instance = ServiceCollection._internal();

  ServiceCollection._internal();
  static const String serviceCollection = "Service Collection";
  factory ServiceCollection() {
    return instance;
  }

  Future<bool> addNewService(Services services) async {
    try {
      await UserCollection.userCollection
          .doc(services.adminId)
          .collection(serviceCollection)
          .doc("${services.serviceId})${services.serviceName}")
          .set(services.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNewService(Services services) async {
    try {
      await UserCollection.userCollection
          .doc(services.adminId)
          .collection(serviceCollection)
          .doc("${services.serviceId})${services.serviceName}")
          .update(services.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNewService(Services services) async {
    try {
      await UserCollection.userCollection
          .doc(services.adminId)
          .collection(serviceCollection)
          .doc("${services.serviceId})${services.serviceName}")
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Car>> getAllCars(String adminId) async {
    try {
      var snapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .get();
      var listOfCars = snapshot.docs
          .map(
            (e) => Services.fromMap(e.data()).cars,
          )
          .toList();
      return listOfCars.first;
    } catch (e) {
      return [];
    }
  }

  Future<List<DateTime>> getAllDates(String adminId) async {
    try {
      var snapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .get();
      var temp = snapshot.docs
          .map(
            (e) => Services.fromMap(e.data()).availableDates,
          )
          .toList();
      return temp.first;
    } catch (e) {
      return [];
    }
  }

  Future<Services> getSpecificService(
      String adminId, String serviceName, int serviceId) async {
    var querySnapshot = await UserCollection.userCollection
        .doc(adminId)
        .collection(serviceCollection)
        .doc("$serviceId)$serviceName")
        .get();
    return Services.fromMap(querySnapshot.data()!);
  }

  Future<List<Services>> getAllServicesByAdmin(String adminId) async {
    try {
      var querySnapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .get();
      return querySnapshot.docs
          .map((doc) => Services.fromMap(doc.data()))
          .toList();
    } catch (e) {
      log('Error fetching services: $e');
      return [];
    }
  }
}
