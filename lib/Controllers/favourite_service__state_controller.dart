import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_booking_counter.dart';
import 'package:car_wash_app/ModelClasses/favourites_booking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteServiceProvider =
    NotifierProvider<FavouriteServiceStateController, FavouriteServiceStates>(
        FavouriteServiceStateController.new);

class FavouriteServiceStateController extends Notifier<FavouriteServiceStates> {
  double? servicePrice;
  double? serviceRating;
  FavouriteCollection favouriteCollection = FavouriteCollection();
  FavouriteServicesCounterCollection favouriteServicesCounterCollection =
      FavouriteServicesCounterCollection();
  @override
  FavouriteServiceStates build() {
    return FavouriteServiceIntialState();
  }

  // Deleting favourite Service
  Future<void> deleteFavouriteService(String favouriteServiceId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var favouriteServiceCount = await favouriteServicesCounterCollection
        .getAllUserBookingsCount(userId);
    var favouriteServiceIdCount = favouriteServiceCount.length + 1;
    var favouriteServiceId = "$favouriteServiceIdCount";
    if (favouriteServiceIdCount < 9) {
      favouriteServiceId = "0$favouriteServiceIdCount";
    }
    try {
      await favouriteCollection.deleteFavouriteService(
          userId, favouriteServiceId);
    } catch (e) {
      log("failed to delete Favourite service :  ${e.toString()}");
    }
  }

  //Adding Favourite Service
  Future<void> addToFavourite(String serviceName, String serviceImageUrl,
      String favouriteServiceId) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    var favouriteServiceCount = await favouriteServicesCounterCollection
        .getAllUserBookingsCount(userId);
    var favouriteServiceIdCount = favouriteServiceCount.length + 1;
    var favouriteServiceId = "${favouriteServiceCount.length + 1}";
    if (favouriteServiceIdCount < 10) {
      favouriteServiceId = "0$favouriteServiceIdCount";
    }
    serviceRating = 5;
    servicePrice = 50;
    try {
      if (servicePrice != null && serviceRating != null) {
        await favouriteCollection.addServiceToFavourite(FavouriteSerivces(
            favouriteServiceId: favouriteServiceId,
            serviceName: serviceName,
            userId: userId,
            serviceRating: serviceRating!,
            serviceImageUrl: serviceImageUrl,
            servicePrice: servicePrice!));
        favouriteServicesCounterCollection.addAdminBookingCount(
            AdminServiceCounter(userId: userId, count: favouriteServiceId));
      }

      await getAllFavouriteService(userId);
    } catch (e) {
      log("Error in adding favourite service : ${e.toString()}");
    }
  }

  // Getting all Services
  Future<void> getAllFavouriteService(String userId) async {
    state = FavouriteServiceLoadingState();
    try {
      var listOfFavouriteServices =
          await favouriteCollection.fetchAllServices(userId);
      state = FavouriteServiceLoadedState(
          listOfFavouriteServices: listOfFavouriteServices);
    } catch (e) {
      log("Error in fetching favourite services ${e.toString()}");
      state = FavouriteServiceErrorState(error: e.toString());
    }
  }
}

abstract class FavouriteServiceStates {}

class FavouriteServiceIntialState extends FavouriteServiceStates {}

class FavouriteServiceLoadingState extends FavouriteServiceStates {}

class FavouriteServiceLoadedState extends FavouriteServiceStates {
  final List<FavouriteSerivces> listOfFavouriteServices;
  FavouriteServiceLoadedState({required this.listOfFavouriteServices});
}

class FavouriteServiceErrorState extends FavouriteServiceStates {
  final String error;
  FavouriteServiceErrorState({required this.error});
}
