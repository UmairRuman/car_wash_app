import 'dart:developer';

import 'package:car_wash_app/Collections.dart/admin_key_collection.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/admin_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminSideEditProfileInfoProvider =
    NotifierProvider<AdminSideEditProfileStateController, String>(
        AdminSideEditProfileStateController.new);

class AdminSideEditProfileStateController extends Notifier<String> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String profileImagePath = "";
  UserCollection userCollection = UserCollection();
  AdminKeyCollection adminKeyCollection = AdminKeyCollection();
  TextEditingController editNameTEC = TextEditingController();
  TextEditingController editPasswordTEC = TextEditingController();
  TextEditingController editPhoneNoTEC = TextEditingController();
  TextEditingController editLocationTEC = TextEditingController();
  @override
  String build() {
    ref.onDispose(
      () {
        editNameTEC.dispose();
        editLocationTEC.dispose();
        editPasswordTEC.dispose();
        editPhoneNoTEC.dispose();
      },
    );
    return "";
  }

  Future<void> onUpdateImage(String newImagePath, BuildContext context) async {
    log("On Update image Method");

    profileImagePath = newImagePath;
    // dialogForUpdatingProfilePicProvider(context);
    await userCollection.updateUserProfilePic(userId, newImagePath);
    // ref.read(userAdditionStateProvider.notifier).getUser(userId);
    // Navigator.of(context).pop();
  }

  onClickEditProfile(
      String name, String password, String phoneNo, String location) {
    editLocationTEC.text = location;
    editNameTEC.text = name;
    editPhoneNoTEC.text = phoneNo;
    editPasswordTEC.text = password;
  }

  Future<void> onClickOnUpdateButton(BuildContext context) async {
    try {
      dialogForUpdatingInfoProvider(context);
      await userCollection.updateUserPhoneNo(userId, editPhoneNoTEC.text);
      await userCollection.updateUserName(userId, editNameTEC.text);
      await userCollection.updateUserLocation(userId, editLocationTEC.text);
      await adminKeyCollection
          .updateAdminKey(AdminKey(pin: editPasswordTEC.text));
      await ref.read(userAdditionStateProvider.notifier).getUser(userId);
      Navigator.of(context).pop();
    } catch (e) {
      log("Error in updating all info");
    }
  }
}

void dialogForUpdatingInfoProvider(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 100,
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Center(
              child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text(
                "Updating Info",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          )),
        ),
      );
    },
  );
}

void dialogForUpdatingProfilePicProvider(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 100,
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Center(
              child: Row(
            children: [
              Spacer(
                flex: 10,
              ),
              Expanded(
                flex: 10,
                child: CircularProgressIndicator(),
              ),
              Spacer(
                flex: 20,
              ),
              Expanded(
                flex: 50,
                child: FittedBox(
                  child: Text(
                    "Updating Profile Pic",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(
                flex: 10,
              ),
            ],
          )),
        ),
      );
    },
  );
}
