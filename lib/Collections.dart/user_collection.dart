import 'dart:developer';

import 'package:car_wash_app/ModelClasses/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollection {
  static final UserCollection instance = UserCollection._internal();
  UserCollection._internal();
  factory UserCollection() {
    return instance;
  }

  static var userCollection =
      FirebaseFirestore.instance.collection("User Collection");

  Future<bool> addUser(Users user) async {
    try {
      await userCollection.doc(user.userId).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(Users user) async {
    try {
      await userCollection.doc(user.userId).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateSpecificField(String userId, String deviceTokken) async {
    try {
      await userCollection.doc(userId).update({"deviceToken": deviceTokken});
      return true;
    } catch (e) {
      log("Error in updating specific user field ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteUser(Users user) async {
    try {
      await userCollection.doc(user.userId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Users>> getAllUsers() async {
    var snapshots = await userCollection.get();
    var list = snapshots.docs
        .map(
          (snapshot) => Users.fromMap(snapshot.data()),
        )
        .toList();
    return list;
  }

  Future<Users> getUser(String userId) async {
    var snapshot = await userCollection.doc(userId).get();

    var singleUserData = Users.fromMap(snapshot.data()!);
    log(snapshot.data()!.toString());
    return singleUserData;
  }
}
