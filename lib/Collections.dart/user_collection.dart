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

  Future<String> getUserName(String userId) async {
    try {
      var snapShot = await userCollection.doc(userId).get();

      return Users.fromMap(snapShot.data()!).name;
      ;
    } catch (e) {
      return "";
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

  Future<bool> updateUserDeviceToken(String userId, String deviceTokken) async {
    try {
      await userCollection.doc(userId).update({"deviceToken": deviceTokken});
      return true;
    } catch (e) {
      log("Error in updating specific user field ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateUserGmail(String userId, String gmail) async {
    try {
      await userCollection.doc(userId).update({"email": gmail});
      return true;
    } catch (e) {
      log("Error in updating specific user gmail ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateUserName(String userId, String userName) async {
    try {
      await userCollection.doc(userId).update({"name": userName});
      return true;
    } catch (e) {
      log("Error in updating user phone no ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateUserLocation(String userId, String userLocation) async {
    try {
      await userCollection.doc(userId).update({"userLocation": userLocation});
      return true;
    } catch (e) {
      log("Error in updating user phone no ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateUserPhoneNo(String userId, String phoneNo) async {
    try {
      await userCollection.doc(userId).update({"phoneNumber": phoneNo});
      return true;
    } catch (e) {
      log("Error in updating user phone no ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateUserNoOfServices(String userId) async {
    try {
      //For updating services firstly we have to get user no of services
      var querrySnapShot = await userCollection.doc(userId).get();
      double noOfServices =
          Users.fromMap(querrySnapShot.data()!).serviceConsumed as double;
      log("No of servicces $noOfServices");
      noOfServices += 1;
      log("No of servicces $noOfServices");
      int actualNoOfServices = noOfServices.toInt();
      await userCollection
          .doc(userId)
          .update({"serviceConsumed": actualNoOfServices});
      return true;
    } catch (e) {
      log("Error in updating useer consumed services ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateUserProfilePic(String userId, String profilePicUrl) async {
    try {
      await userCollection.doc(userId).update({"profilePicUrl": profilePicUrl});
      return true;
    } catch (e) {
      log("Error in updating useer consumed services ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateUserBonusPoints(String userId) async {
    try {
      var querrySnapShot = await userCollection.doc(userId).get();
      double bonusPoints = Users.fromMap(querrySnapShot.data()!).bonusPoints;
      bonusPoints += 300;
      await userCollection.doc(userId).update({"bonusPoints": bonusPoints});
      return true;
    } catch (e) {
      log("Error in updating useer consumed services ${e.toString()}");
      return false;
    }
  }

  Future<String> getUserLocation(String userId) async {
    try {
      var querrySnapshot = await userCollection.doc(userId).get();

      return Users.fromMap(querrySnapshot.data()!).userLocation;
    } catch (e) {
      return "";
    }
  }

  Future<String> getUserPhoneNumber(String userId) async {
    try {
      var querrySnapshot = await userCollection.doc(userId).get();

      return Users.fromMap(querrySnapshot.data()!).phoneNumber;
    } catch (e) {
      return "";
    }
  }

  Future<bool> getUserInfo(String userId) async {
    try {
      var querrySnapshot = await userCollection.doc(userId).get();

      return Users.fromMap(querrySnapshot.data()!).isServiceProvider;
    } catch (e) {
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

  Future<String> getUserPic(String adminId) async {
    try {
      var querrySnapShot = await userCollection.doc(adminId).get();
      return Users.fromMap(querrySnapShot.data()!).profilePicUrl;
    } catch (e) {
      return "";
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

    return singleUserData;
  }
}
