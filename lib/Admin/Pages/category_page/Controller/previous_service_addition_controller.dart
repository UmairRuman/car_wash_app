import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/previous_service_collection_couter.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/previous_work_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/rating_collection.dart';
import 'package:car_wash_app/ModelClasses/previous_work_model.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviousServiceAdditionController extends Notifier<PreviousDataStates> {
  String? adminId = prefs!.getString(SharedPreferncesConstants.adminkey) == ""
      ? FirebaseAuth.instance.currentUser!.uid
      : prefs!.getString(SharedPreferncesConstants.adminkey);

  List<PreviousWorkModel> intialList = [];
  TextEditingController previousServiceNameTEC = TextEditingController();
  RatingCollection ratingCollection = RatingCollection();
  String previusWorkImagePath = "";
  PreviousWorkCollection previousWorkCollection = PreviousWorkCollection();
  PreviousServiceCounterCollection previousServiceCounterCollection =
      PreviousServiceCounterCollection();
  bool isNewPathSet = false;
  @override
  PreviousDataStates build() {
    ref.onDispose(
      () {
        previousServiceNameTEC.dispose();
      },
    );
    return PreviousDataInitialState();
  }

  Future<void> getIntialListPreviousServices() async {
    try {
      intialList = await previousWorkCollection.getAllPreviousWork(adminId!);
    } catch (e) {
      log("Error in getting previous Intial list");
    }
  }

  void setNewPreviousImage(String newImagePath) {
    isNewPathSet = true;
    previusWorkImagePath = newImagePath;
  }

  Future<void> getAllPreviousData() async {
    state = PreviousDataLoadingState();
    try {
      var listOfPreviousWorks =
          await previousWorkCollection.getAllPreviousWork(adminId!);
      state = PreviousDataLoadedState(list: listOfPreviousWorks);
    } catch (e) {
      state = PreviousDataErrorState(error: e.toString());
      log("Error in getting previous Work Images");
    }
  }

  Future<void> addDefaultPreviousWorkCategories() async {
    try {
      for (int index = 0; index < listOfPreviousWorkImages.length; index++) {
        var serviceId =
            await previousWorkCollection.getLastPreviousWorkId(adminId!);
        String countId;

        if (int.parse(serviceId) < 9) {
          countId = "0${int.parse(serviceId) + 1}";
        } else if (serviceId == "") {
          countId = "01";
        } else {
          countId = "${int.parse(serviceId) + 1}";
        }

        await previousWorkCollection.addPreviousData(
            adminId!,
            PreviousWorkModel(
                isAssetImage: true,
                previousWorkImage: listOfPreviousWorkImages[index],
                serviceName: listOfCategoryName[index],
                serviceRating: 5.0,
                serviceProvideTime: DateTime.now(),
                id: countId));
        // previousServiceCounterCollection.addCount(
        //     PreviousServiceCounter(count: countId), adminId!);
      }
    } catch (e) {
      log("Error in adding Default Previous Work Images");
    }
  }

  Future<void> insertPreviousData() async {
    if (isNewPathSet) {
      var previousServiceCount =
          await previousWorkCollection.getLastPreviousWorkId(adminId!);
      log("List Of previous service list : ${int.parse(previousServiceCount)}  ");
      String countId;
      if (int.parse(previousServiceCount) < 9) {
        countId = "0${int.parse(previousServiceCount) + 1}";
      } else {
        countId = "${int.parse(previousServiceCount) + 1}";
      }
      log("Count id $countId");
      try {
        previousWorkCollection.addPreviousData(
            adminId!,
            PreviousWorkModel(
                isAssetImage: false,
                previousWorkImage: previusWorkImagePath,
                serviceName: previousServiceNameTEC.text,
                serviceRating: 5.0,
                serviceProvideTime: DateTime.now(),
                id: countId));

        // previousServiceCounterCollection.addCount(
        //     PreviousServiceCounter(count: countId), adminId!);
        await getAllPreviousData();
      } catch (e) {
        log("Error in adding previous Work data");
      }
    }
  }

  void deleteSpecificPreviousData(String previousServiceId) async {
    try {
      previousWorkCollection.deletePreviousData(adminId!, previousServiceId);
      await getAllPreviousData();
    } catch (e) {
      log("Error in deleting Previous Work");
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

class PreviousDataErrorState extends PreviousDataStates {
  final String error;
  PreviousDataErrorState({required this.error});
}
