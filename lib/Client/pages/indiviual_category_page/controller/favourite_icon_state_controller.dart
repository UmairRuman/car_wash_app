import 'dart:developer';

import 'package:car_wash_app/Collections.dart/sub_collections.dart/favourite_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteIconStateProvider =
    NotifierProvider<FavouriteIconStateController, bool>(
        FavouriteIconStateController.new);

class FavouriteIconStateController extends Notifier<bool> {
  FavouriteCollection favouriteCollection = FavouriteCollection();

  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  bool build() {
    return false;
  }

  Future<void> checkForFavouriteOrNot(String serviceId) async {
    try {
      bool isServiceFavourite = await favouriteCollection
          .checkFavouriteCategoryImage(userId, serviceId);
      state = isServiceFavourite;
    } catch (e) {
      log("Error in checking favourite service");
    }
  }
}
