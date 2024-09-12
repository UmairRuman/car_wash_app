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
      log("Error adding time slot: $e");
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
      log("Error updating time slot: $e");
      return false;
    }
  }

  Future<bool> deleteSpecificTimeSlot(
      String adminId, int index, DateTime date) async {
    try {
      var querySnapshots = await UserCollection.userCollection
          .doc(adminId)
          .collection(timeSlotCollection)
          .doc(date.toIso8601String())
          .get();
      var listOfTimeSlots = TimeSlots.fromMap(querySnapshots.data()!);

      if (index < 0 || index >= listOfTimeSlots.timeslots.length) {
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
      log("Error deleting specific time slot: $e");
      return false;
    }
  }

  Future<bool> deleteAllTimeSlots(String userId) async {
    try {
      // Fetch all the documents in the timeSlotCollection
      var snapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(timeSlotCollection)
          .get();

      // Loop through each document and delete it
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }

      log("All time slots deleted for user $userId");
      return true;
    } catch (e) {
      log("Error deleting all time slots: $e");
      return false;
    }
  }

  Future<List<String>> getSpecificDateSlots(
      String adminId, DateTime dateTime) async {
    try {
      String docId = dateTime.toIso8601String();
      log("Fetching time slots for doc ID: $docId");

      var querySnapshots = await UserCollection.userCollection
          .doc(adminId)
          .collection(timeSlotCollection)
          .doc(docId)
          .get();
      log("Path ${UserCollection.userCollection.doc(adminId).collection(timeSlotCollection).doc(docId).path}");
      if (querySnapshots.exists && querySnapshots.data() != null) {
        log("Document data: ${querySnapshots.data()}");
        return TimeSlots.fromMap(querySnapshots.data()!).timeslots;
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
      var querySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(timeSlotCollection)
          .get();
      return querySnapshots.docs
          .map(
            (doc) => TimeSlots.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      log("Error getting all time slots: $e");
      return [];
    }
  }

  // New Function to Get All Existing Dates
  Future<List<DateTime>> getExistingDays(String userId) async {
    try {
      var querySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(timeSlotCollection)
          .get();
      return querySnapshots.docs.map((doc) => DateTime.parse(doc.id)).toList();
    } catch (e) {
      log("Error getting existing days: $e");
      return [];
    }
  }

  // New Function to Remove a Specific Date
  Future<bool> removeDate(String userId, DateTime date) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(timeSlotCollection)
          .doc(date.toIso8601String())
          .delete();
      log("Date removed: ${date.toIso8601String()}");
      return true;
    } catch (e) {
      log("Error removing date: $e");
      return false;
    }
  }
}
