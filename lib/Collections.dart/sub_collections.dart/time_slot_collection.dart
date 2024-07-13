import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/time_slot.dart';

class TimeSlotCollection {
  static final TimeSlotCollection instance = TimeSlotCollection._internal();
  TimeSlotCollection._internal();
  factory TimeSlotCollection() {
    return instance;
  }
  static String timeSlotCollection = "Time Slots";
  Future<bool> addTimeSlots(
    TimeSlots timeslot,
    String userId,
    int serviceId,
  ) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(ServiceCollection.serviceCollection)
          .doc("$serviceId)${timeslot.serviceName}")
          .collection(timeSlotCollection)
          .doc(timeslot.currentDate.toIso8601String())
          .set(timeslot.toMap());
      log("Time Slot added ${timeslot.currentDate.toIso8601String()}");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTimeSlots(
      TimeSlots timeslot, String userId, int serviceId) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(ServiceCollection.serviceCollection)
          .doc("$serviceId)${timeslot.serviceName}")
          .collection(timeSlotCollection)
          .doc(timeslot.currentDate.toIso8601String())
          .update(timeslot.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTimeSlots(
      TimeSlots timeslot, String userId, int serviceId) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(ServiceCollection.serviceCollection)
          .doc("$serviceId)${timeslot.serviceName}")
          .collection(timeSlotCollection)
          .doc(timeslot.currentDate.toIso8601String())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getSpecificDateSlots(String adminId, int serviceId,
      String serviceName, DateTime dateTime) async {
    try {
      String docId = dateTime.toIso8601String();
      log("Fetching time slots for doc ID: $docId");

      var querrySnapshots = await UserCollection.userCollection
          .doc(adminId)
          .collection(ServiceCollection.serviceCollection)
          .doc("$serviceId)$serviceName")
          .collection(timeSlotCollection)
          .doc(docId)
          .get();

      if (querrySnapshots.exists && querrySnapshots.data() != null) {
        log("Document data: ${querrySnapshots.data()}");
        return TimeSlots.fromMap(querrySnapshots.data()!).timeslots;
      } else {
        log("Document does not exist or has no data");
        return [];
      }
    } catch (e) {
      log("Error fetching time slots: $e");
      return [];
    }
  }

  Future<List<TimeSlots>> getAllTimeSlots(
      String serviceName, String userId, int serviceId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(ServiceCollection.serviceCollection)
          .doc("$serviceId)$serviceName")
          .collection(TimeSlotCollection.timeSlotCollection)
          .get();
      return querrySnapshots.docs
          .map(
            (doc) => TimeSlots.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
