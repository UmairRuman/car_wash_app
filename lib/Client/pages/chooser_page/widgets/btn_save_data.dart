import 'dart:developer';

import 'package:car_wash_app/Client/pages/chooser_page/controller/save_data_notifier.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BtnSaveUserData extends ConsumerWidget {
  const BtnSaveUserData({super.key});

  void onClickSaveButton(WidgetRef ref, BuildContext context) {
    String userLocation = ref
        .read(userAdditionStateProvider.notifier)
        .listOfUserInfo[MapForUserInfo.userLocation];
    String userPhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber!;
    String userProfilePic = ref
        .read(userAdditionStateProvider.notifier)
        .listOfUserInfo[MapForUserInfo.profilePicUrl];

    log("User profile Pic in On Save Btn ${userProfilePic}");

    log("User Phone No ${FirebaseAuth.instance.currentUser!.phoneNumber}");
    if (userLocation != "" &&
        FirebaseAuth.instance.currentUser!.phoneNumber != "" &&
        userProfilePic != "") {
      ref.read(userAdditionStateProvider.notifier).addUser();
      ref.read(userAdditionStateProvider.notifier).isUserDataAdded = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitPouringHourGlass(
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Wait, Adding Your Configrations... ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
      );
      ref.read(userSaveStateProvider.notifier).onSavedUserState();
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pop();
      });
    } else if (userProfilePic == "") {
      Fluttertoast.showToast(
          msg: "Kindly add your profile Pic!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if (userLocation == "") {
      Fluttertoast.showToast(
          msg: "Kindly Add your location!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if (userPhoneNumber == "") {
      Fluttertoast.showToast(
          msg: "Kindly authenticate your phone number!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(
            flex: 50,
            child: MaterialButton(
              onPressed: () async {
                final connectivityResult =
                    await Connectivity().checkConnectivity();
                if (connectivityResult[0] == ConnectivityResult.none) {
                  // No internet connection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No internet connection'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  onClickSaveButton(ref, context);
                }
              },
              color: const Color.fromARGB(255, 57, 162, 61),
              child: const Text(
                "Save Data",
                style: TextStyle(color: Colors.white),
              ),
            )),
        const Spacer(
          flex: 25,
        ),
      ],
    );
  }
}
