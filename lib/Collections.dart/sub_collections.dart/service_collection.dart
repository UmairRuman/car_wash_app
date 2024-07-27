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

  Future<bool> deleteSpecificService(
      String adminId, String serviceName, String serviceId) async {
    try {
      await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Car>> getAllCarsAtSpecificDocument(
      String adminId, String serviceId, String serviceName) async {
    try {
      var snapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .get();

      var listOfCars = Services.fromMap(snapshot.data()!).cars;
      return listOfCars;
    } catch (e) {
      return [];
    }
  }

  Future<bool> deleteCarFromList(
      String adminId, String serviceId, String serviceName, int index) async {
    try {
      var snapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .get();

      if (!snapshot.exists) {
        return false;
      }

      var serviceData = Services.fromMap(snapshot.data()!);

      if (index < 0 || index >= serviceData.cars.length) {
        return false;
      }

      // Remove the car at the specified index
      serviceData.cars.removeAt(index);

      // Update the document in Firestore
      await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .update(serviceData.toMap());

      return true;
    } catch (e) {
      return false;
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
      String adminId, String serviceName, String serviceId) async {
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
