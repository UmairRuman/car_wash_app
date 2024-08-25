import 'dart:developer';

import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';

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

  Future<bool> updateCarList(
      String adminId, String serviceId, String serviceName, Car car) async {
    try {
      // Get the existing list of cars
      var snapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .get();

      List<dynamic> existingCars = snapshot.data()?['cars'] ?? [];

      // Add the new car to the list
      existingCars.add({
        'carName': car.carName,
        'isAsset': car.isAsset,
        'price': car.price,
        'url': car.url,
      });

      // Update the document with the new car list
      await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .update({"cars": existingCars});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateServiceImagePath(String imagePath, String serviceName,
      String serviceId, String adminId) async {
    try {
      await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .update({"imageUrl": imagePath});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateServiceDescription(String serviceDescrptiion,
      String serviceName, String serviceId, String adminId) async {
    try {
      await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .update({"description": serviceDescrptiion});
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

  Future<bool> updateCarInfo(
      String adminId,
      String serviceId,
      String carOldName,
      String serviceName,
      String carPrice,
      String carName,
      String carImagePath,
      bool isAssetImage) async {
    try {
      final docRef = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName");

      final snapshot = await docRef.get();
      log("Snapshot Data  : ${snapshot.data().toString()}");
      if (snapshot.exists) {
        final data = snapshot.data();

        List cars = data?['cars'] ?? [];

        // Find the car to update
        final index = cars.indexWhere((car) => car['carName'] == carOldName);

        if (index != -1) {
          // Remove the old map
          cars.removeAt(index);

          // Create the updated map
          final updatedCar = {
            'carName': carName,
            'price': carPrice,
            'url': carImagePath,
            'isAsset': isAssetImage,
          };
          log("Updated Car ${updatedCar.toString()}");

          // Add the updated map
          cars.add(updatedCar);

          // Update the document with the new cars array
          await docRef.update({'cars': cars});
          return true;
        }
      }
      return false;
    } catch (e) {
      log('Error updating car info: $e');
      return false;
    }
  }

  Future<dynamic> getSpecificService(
      String adminId, String serviceName, String serviceId) async {
    try {
      var querySnapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .get();
      print(querySnapshot.data());
      return Services.fromMap(querySnapshot.data()!);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> updateFavouriteServiceId(String adminId, String serviceName,
      String serviceId, String favouriteServiceId) async {
    try {
      var querrySnapShots = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .update({"serviceFavouriteId": favouriteServiceId});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<double> getServicePrice(
      String adminId, String serviceName, String serviceId) async {
    try {
      var querrySnapShots = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .get();
      var list = Services.fromMap(querrySnapShots.data()!).cars;
      double averagePrice;
      int sum = 0;
      for (int index = 0; index < list.length; index++) {
        String singleCarPrice = list[index].price;
        int priceInInt =
            int.parse(singleCarPrice.substring(0, singleCarPrice.length - 1));
        sum += priceInInt;
      }
      averagePrice = sum / list.length;
      return averagePrice;
    } catch (e) {
      return 0.0;
    }
  }

  Future<double> getServiceRating(
      String adminId, String serviceName, String serviceId) async {
    try {
      var querrySnapShots = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .doc("$serviceId)$serviceName")
          .get();
      return Services.fromMap(querrySnapShots.data()!).rating;
    } catch (e) {
      return 0.0;
    }
  }

  Future<String> getLastServiceId(String adminId) async {
    try {
      var querrySnapShots = await UserCollection.userCollection
          .doc(adminId)
          .collection(serviceCollection)
          .get();
      var list = querrySnapShots.docs
          .map(
            (doc) => Services.fromMap(doc.data()),
          )
          .toList();
      if (list.isEmpty) {
        return "";
      }
      return list.last.serviceId;
    } catch (e) {
      return "";
    }
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
