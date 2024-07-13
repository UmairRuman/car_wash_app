import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/previous_service_counter.dart';

class PreviousServiceCounterCollection {
  static final PreviousServiceCounterCollection instance =
      PreviousServiceCounterCollection._internal();

  PreviousServiceCounterCollection._internal();
  static const previousServiceCollectionCounter =
      "Previous Service Collection Counter";
  factory PreviousServiceCounterCollection() {
    return instance;
  }

  Future<bool> addCount(
      PreviousServiceCounter serviceCounter, String userId) async {
    try {
      UserCollection.userCollection
          .doc(userId)
          .collection(previousServiceCollectionCounter)
          .doc(serviceCounter.count.toString())
          .set(serviceCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCount(
      PreviousServiceCounter serviceCounter, String userId) async {
    try {
      UserCollection.userCollection
          .doc(userId)
          .collection(previousServiceCollectionCounter)
          .doc(serviceCounter.count.toString())
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCount(
      PreviousServiceCounter serviceCounter, String userId) async {
    try {
      UserCollection.userCollection
          .doc(userId)
          .collection(previousServiceCollectionCounter)
          .doc(serviceCounter.count.toString())
          .update(serviceCounter.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<PreviousServiceCounter>> getAllPreviousServiceCount(
      String userId) async {
    try {
      var querrySnapshot = await UserCollection.userCollection
          .doc(userId)
          .collection(previousServiceCollectionCounter)
          .get();
      return querrySnapshot.docs
          .map(
            (doc) => PreviousServiceCounter.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
