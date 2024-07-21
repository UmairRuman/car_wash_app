import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:car_wash_app/ModelClasses/favourites_booking.dart';

class FavouriteCollection {
  static final FavouriteCollection instance = FavouriteCollection._internal();
  FavouriteCollection._internal();
  static const String favouriteCollection = "Favourite Collection";
  factory FavouriteCollection() {
    return instance;
  }
  Future<bool> addServiceToFavourite(FavouriteSerivces service) async {
    try {
      UserCollection.userCollection
          .doc(service.userId)
          .collection(favouriteCollection)
          .doc(service.favouriteServiceId.toString())
          .set(service.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateFavouriteService(FavouriteSerivces service) async {
    try {
      UserCollection.userCollection
          .doc(service.userId)
          .collection(favouriteCollection)
          .doc(service.favouriteServiceId.toString())
          .update(service.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteFavouriteService(
      String userId, String favouriteServiceId) async {
    try {
      UserCollection.userCollection
          .doc(userId)
          .collection(favouriteCollection)
          .doc(favouriteServiceId.toString())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<FavouriteSerivces>> fetchAllServices(String userId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(favouriteCollection)
          .get();
      return querrySnapshots.docs
          .map(
            (doc) => FavouriteSerivces.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
