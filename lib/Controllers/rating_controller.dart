import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/rating_collection.dart';
import 'package:car_wash_app/ModelClasses/Ratings.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingStateProvider =
    NotifierProvider<RatingStateController, RatingsFetchingStates>(
        RatingStateController.new);

class RatingStateController extends Notifier<RatingsFetchingStates> {
  var adminId = prefs!.getString(SharedPreferncesConstants.adminkey) == ""
      ? FirebaseAuth.instance.currentUser!.uid
      : prefs!.getString(SharedPreferncesConstants.adminkey);
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String userName = FirebaseAuth.instance.currentUser!.displayName!;
  double finalRating = 1;
  bool isServiceRated = false;
  List<Ratings> listOfRatings = [];

  RatingCollection ratingCollection = RatingCollection();
  @override
  RatingsFetchingStates build() {
    return RatingFetchingIntialState();
  }

//Addding rating , which is obiously done by client
  Future<void> addRatingFromUser(
    String serviceId,
    String serviceName,
    double serviceRating,
    bool isServiceRated,
  ) async {
    Ratings rating = Ratings(
        serviceId: serviceId,
        serviceName: serviceName,
        userId: userId,
        rating: serviceRating,
        userName: userName,
        isServiceRated: isServiceRated);
    try {
      await ratingCollection.addRating(rating, adminId!);
      await getSpecificUserRating(serviceId, serviceName);
    } catch (e) {
      log("Error in adding Ratings");
    }
  }

//Getting all ratings which i have to show on admin side
  Future<void> getAllRatings(String serviceId, String serviceName) async {
    state = RatingFetchingLoadingState();
    try {
      listOfRatings = await ratingCollection.fetchAllRatings(
          adminId!, serviceId, serviceName);
      state = RatingFetchingLoadedState(listOfRatings: listOfRatings);
    } catch (e) {
      state = RatingFetchingErrorState(error: e.toString());
      log("Error in fetching Ratings");
    }
  }

  //Getting a specific user Rating which i have to show on client side to user
  Future<void> getSpecificUserRating(
      String serviceId, String serviceName) async {
    try {
      Ratings ratings = await ratingCollection.fetchUserRating(
          adminId!, serviceId, serviceName, userId);
      finalRating = ratings.rating;
      log("Final Rating $finalRating");
      isServiceRated = ratings.isServiceRated;
    } catch (e) {
      log("Failed to fetching specific user id ");
    }
  }
}

abstract class RatingsFetchingStates {
  const RatingsFetchingStates();
}

class RatingFetchingIntialState extends RatingsFetchingStates {}

class RatingFetchingLoadingState extends RatingsFetchingStates {}

class RatingFetchingLoadedState extends RatingsFetchingStates {
  final List<Ratings> listOfRatings;
  const RatingFetchingLoadedState({required this.listOfRatings});
}

class RatingFetchingErrorState extends RatingsFetchingStates {
  final String error;
  const RatingFetchingErrorState({required this.error});
}
