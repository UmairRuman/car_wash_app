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
  Future<bool> addServiceToFavourite(FavouriteServices service) async {
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

  Future<bool> updateFavouriteService(FavouriteServices service) async {
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

  Future<String> getLastFavouriteServiceId(String userId) async {
    try {
      var snapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(favouriteCollection)
          .get();
      var list = snapshots.docs
          .map(
            (doc) => FavouriteServices.fromMap(doc.data()),
          )
          .toList();
      return list.last.favouriteServiceId;
    } catch (e) {
      return "";
    }
  }

  Future<List<FavouriteServices>> fetchAllServices(String userId) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(userId)
          .collection(favouriteCollection)
          .orderBy("createdAt", descending: false)
          .get();
      return querrySnapshots.docs
          .map(
            (doc) => FavouriteServices.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
