import 'dart:developer';

import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/Services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          .doc(services.serviceId)
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
          .doc(services.serviceId)
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
          .doc(services.serviceId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Services>> getServicesByAdmin(String adminId) async {
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
