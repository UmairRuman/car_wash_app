import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/Ratings.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';

class RatingCollection {
  static final RatingCollection instance = RatingCollection._internal();
  RatingCollection._internal();
  factory RatingCollection() {
    return instance;
  }
  static const ratingCollection = "Ratings Collection";

  Future<bool> addRating(Ratings rating, String adminId) async {
    try {
      //Adding rating at rating collection
      UserCollection.userCollection
          .doc(adminId)
          .collection(ServiceCollection.serviceCollection)
          .doc("${rating.serviceId})${rating.serviceName}")
          .collection(RatingCollection.ratingCollection)
          .doc(rating.userId)
          .set(rating.toMap());

      //After adding rating we also have to change service rating
      var listOfRatings =
          await fetchAllRatings(adminId, rating.serviceId, rating.serviceName);

      double ratingSum = 0;
      for (var i = 0; i < listOfRatings.length; i++) {
        ratingSum += listOfRatings[i].rating;
      }

      double totalRating = ratingSum / listOfRatings.length;

      await UserCollection.userCollection
          .doc(adminId)
          .collection(ServiceCollection.serviceCollection)
          .doc("${rating.serviceId})${rating.serviceName}")
          .update({"rating": totalRating});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateRating(Ratings rating, String adminId) async {
    try {
      UserCollection.userCollection
          .doc(adminId)
          .collection(ServiceCollection.serviceCollection)
          .doc("${rating.serviceId})${rating.serviceName}")
          .collection(RatingCollection.ratingCollection)
          .doc(rating.userId)
          .update(rating.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteRating(Ratings rating, String adminId) async {
    try {
      UserCollection.userCollection
          .doc(adminId)
          .collection(ServiceCollection.serviceCollection)
          .doc("${rating.serviceId})${rating.serviceName}")
          .collection(RatingCollection.ratingCollection)
          .doc(rating.userId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Ratings> fetchUserRating(String adminId, String serviceId,
      String serviceName, String userId) async {
    try {
      var querrySnapshot = await UserCollection.userCollection
          .doc(adminId)
          .collection(ServiceCollection.serviceCollection)
          .doc("$serviceId)$serviceName")
          .collection(RatingCollection.ratingCollection)
          .doc(userId)
          .get();

      return Ratings.fromMap(querrySnapshot.data()!);
    } catch (e) {
      return Ratings(
          serviceId: "",
          serviceName: "",
          userId: "",
          rating: 0,
          userName: "",
          isServiceRated: false);
    }
  }

  Future<List<Ratings>> fetchAllRatings(
      String adminId, String serviceId, String serviceName) async {
    try {
      var querrySnapshots = await UserCollection.userCollection
          .doc(adminId)
          .collection(ServiceCollection.serviceCollection)
          .doc("$serviceId)$serviceName")
          .collection(RatingCollection.ratingCollection)
          .get();

      return querrySnapshots.docs
          .map(
            (doc) => Ratings.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
