import 'package:car_wash_app/Collections.dart/sub_collections.dart/previous_service_collection_couter.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/previous_work_collection.dart';
import 'package:car_wash_app/ModelClasses/previous_service_counter.dart';
import 'package:car_wash_app/ModelClasses/previous_work_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviousServiceAdditionController extends Notifier<PreviousDataStates> {
  TextEditingController previousServiceNameTEC = TextEditingController();
  String previusWorkImagePath = "";
  PreviousWorkCollection previousWorkCollection = PreviousWorkCollection();
  PreviousServiceCounterCollection previousServiceCounterCollection =
      PreviousServiceCounterCollection();
  bool isNewPathSet = false;
  @override
  PreviousDataStates build() {
    return PreviousDataInitialState();
  }

  void setNewPreviousImage(String newImagePath) {
    previusWorkImagePath = newImagePath;
    isNewPathSet = true;
  }

  Future<void> insertPreviousData() async {
    if (FirebaseAuth.instance.currentUser != null && isNewPathSet) {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      var listOfServiceCount = await previousServiceCounterCollection
          .getAllPreviousServiceCount(currentUserId);

      previousWorkCollection.addPreviousData(
          currentUserId,
          PreviousWorkModel(
              previousWorkImage: previusWorkImagePath,
              serviceName: previousServiceNameTEC.text,
              serviceRating: 5.0,
              serviceProvideTime: DateTime.now(),
              id: listOfServiceCount.length));

      previousServiceCounterCollection.addCount(
          PreviousServiceCounter(count: listOfServiceCount.length + 1),
          currentUserId);
    }
  }
}

final previousServiceStateProvider =
    NotifierProvider<PreviousServiceAdditionController, PreviousDataStates>(
        PreviousServiceAdditionController.new);

abstract class PreviousDataStates {}

class PreviousDataInitialState extends PreviousDataStates {}

class PreviousDataLoadingState extends PreviousDataStates {}

class PreviousDataLoadedState extends PreviousDataStates {
  final List<PreviousWorkModel> list;
  PreviousDataLoadedState({required this.list});
}

class PreviousDataErrorState {
  final String error;
  PreviousDataErrorState({required this.error});
}
