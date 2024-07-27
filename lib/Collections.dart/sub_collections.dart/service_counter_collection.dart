import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/car_service_counter.dart';

class ServiceCounterCollection {
  static final ServiceCounterCollection instance =
      ServiceCounterCollection._internal();

  ServiceCounterCollection._internal();
  static const previousServiceCollectionCounter = "Service Collection Counter";
  factory ServiceCounterCollection() {
    return instance;
  }

  Future<bool> addCount(ServiceCounter serviceCounter, String userId) async {
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

  Future<bool> deleteCount(String serviceId, String userId) async {
    try {
      UserCollection.userCollection
          .doc(userId)
          .collection(previousServiceCollectionCounter)
          .doc(serviceId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCount(ServiceCounter serviceCounter, String userId) async {
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

  Future<List<ServiceCounter>> getAllServiceCount(String userId) async {
    try {
      var querrySnapshot = await UserCollection.userCollection
          .doc(userId)
          .collection(previousServiceCollectionCounter)
          .get();
      return querrySnapshot.docs
          .map(
            (doc) => ServiceCounter.fromMap(doc.data()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
