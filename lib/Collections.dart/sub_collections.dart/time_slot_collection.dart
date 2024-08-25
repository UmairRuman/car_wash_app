import 'dart:developer';

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
  ) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(timeSlotCollection)
          .doc(timeslot.currentDate.toIso8601String())
          .set(timeslot.toMap());
      log("Time Slot added ${timeslot.currentDate.toIso8601String()}");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTimeSlots(TimeSlots timeslot, String adminId) async {
    try {
      await UserCollection.userCollection
          .doc(adminId)
          .collection(timeSlotCollection)
          .doc(timeslot.currentDate.toIso8601String())
          .update(timeslot.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteSpecificTimeSlot(
      String adminId, int index, DateTime date) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(adminId)
          .collection(TimeSlotCollection.timeSlotCollection)
          .doc(date.toIso8601String())
          .get();
      var listOfTimeSlots = TimeSlots.fromMap(querrySnapshots.data()!);

      if (index < 0 && index >= listOfTimeSlots.timeslots.length) {
        return false;
      }
      listOfTimeSlots.timeslots.removeAt(index);

      await UserCollection.userCollection
          .doc(adminId)
          .collection(timeSlotCollection)
          .doc(date.toIso8601String())
          .update(listOfTimeSlots.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAllTimeSlots(TimeSlots timeslot, String userId) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(timeSlotCollection)
          .doc(timeslot.currentDate.toIso8601String())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getSpecificDateSlots(
      String adminId, DateTime dateTime) async {
    try {
      String docId = dateTime.toIso8601String();
      log("Fetching time slots for doc ID: $docId");

      var querrySnapshots = await UserCollection.userCollection
          .doc(adminId)
          .collection(timeSlotCollection)
          .doc(docId)
          .get();
      log("Path ${UserCollection.userCollection.doc(adminId).collection(timeSlotCollection).doc(docId).path}");
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

  Future<List<TimeSlots>> getAllTimeSlots(String userId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(userId)
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
