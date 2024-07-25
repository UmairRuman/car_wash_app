import 'dart:developer';

import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/ModelClasses/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileDataStateProvider =
    NotifierProvider<ProfileStateController, String>(
        ProfileStateController.new);

class ProfileStateController extends Notifier<String> {
  UserCollection userCollection = UserCollection();
  Users? userData;
  @override
  String build() {
    return "";
  }

  Future<void> getUserAllDData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      userData = await userCollection.getUser(userId);
    } catch (e) {
      log("Getting error in fetching data For user");
    }
  }
}
