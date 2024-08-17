import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/Users.dart';
import 'package:car_wash_app/ModelClasses/previous_work_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PreviousWorkCollection {
  static final PreviousWorkCollection instance =
      PreviousWorkCollection._internal();
  PreviousWorkCollection._internal();
  factory PreviousWorkCollection() {
    return instance;
  }
  static String previousWorkCollectionName = "Previous Works";
  Future<bool> addPreviousData(
      String userId, PreviousWorkModel previousWorkModel) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(previousWorkCollectionName)
          .doc(previousWorkModel.id.toString())
          .set(previousWorkModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePreviousData(
      String userId, String previousServiceid) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(previousWorkCollectionName)
          .doc(previousServiceid)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePreviousData(
      String userId, PreviousWorkModel previousWorkModel) async {
    try {
      await UserCollection.userCollection
          .doc(userId)
          .collection(previousWorkCollectionName)
          .doc(previousWorkModel.id.toString())
          .update(previousWorkModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getLastPreviousWorkId(String userId) async {
    try {
      var snapShots = await UserCollection.userCollection
          .doc(userId)
          .collection(previousWorkCollectionName)
          .get();
      var list = snapShots.docs
          .map(
            (doc) => PreviousWorkModel.fromMap(doc.data()),
          )
          .toList();
      if (list.isEmpty) {
        return "";
      }

      return list.last.id;
    } catch (e) {
      return "";
    }
  }

  Future<List<PreviousWorkModel>> getAllPreviousWork(String userId) async {
    try {
      var snapshot = await UserCollection.userCollection
          .doc(userId)
          .collection(previousWorkCollectionName)
          .get();
      return snapshot.docs
          .map((e) => PreviousWorkModel.fromMap(e.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
