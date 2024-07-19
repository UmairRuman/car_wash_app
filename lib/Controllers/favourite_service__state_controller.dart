import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_service_counter_collection.dart';
import 'package:car_wash_app/ModelClasses/admin_booking_counter.dart';
import 'package:car_wash_app/ModelClasses/favourites_booking.dart';
import 'package:car_wash_app/main.dart';
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

  Future<void> addToFavourite(
      String serviceId, String serviceName, String serviceImageUrl) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    var favouriteServiceCount = await favouriteServicesCounterCollection
        .getAllUserBookingsCount(userId);
    try {
      if (servicePrice != null && serviceRating != null) {
        await favouriteCollection.addServiceToFavourite(FavouriteSerivces(
            favouriteServiceId: favouriteServiceCount.length,
            serviceName: serviceName,
            userId: userId,
            serviceRating: serviceRating!,
            serviceImageUrl: serviceImageUrl,
            servicePrice: servicePrice!));
        favouriteServiceCount.add(FavouriteServicesCounter(
            userId: userId, count: favouriteServiceCount.length + 1));
      }
    } catch (e) {
      log("Error in adding favourite service : ${e.toString()}");
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
