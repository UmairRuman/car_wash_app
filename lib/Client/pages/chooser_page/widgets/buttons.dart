import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/default_services_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/phone_authenticatio_notifier.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/save_data_notifier.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/verification_state_notifier.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BtnContinueChooserPage extends ConsumerWidget {
  const BtnContinueChooserPage({super.key});

  void myDialog(BuildContext context) {
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
                SpinKitWanderingCubes(
                  color: Colors.white,
                  size: 60,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Wait, Setting environment for you ... ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool userSaveState = ref.watch(userSaveStateProvider);
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: FloatingActionButton(
              heroTag: "22",
              onPressed: () async {
                if (userSaveState) {
                  log("Is User Data Added Continue ${ref.read(userAdditionStateProvider.notifier).isUserDataAdded}");
                  if (ref
                      .read(userAdditionStateProvider.notifier)
                      .isUserDataAdded) {
                    //If Service provider is true then i take user to the admin home page
                    if (ref
                        .read(userAdditionStateProvider.notifier)
                        .listOfUserInfo[MapForUserInfo.isServiceProvider]) {
                      log("Lets navigate to Admin home page ");

                      log("Admin Key is null");
                      myDialog(context);

                      await ref
                          .read(previousServiceStateProvider.notifier)
                          .addDefaultPreviousWorkCategories();
                      await ref
                          .read(defaultServicesStateProvider.notifier)
                          .addDefaultService();
                      Navigator.of(context).pop();

                      Navigator.of(context)
                          .pushNamed(AdminSideHomePage.pageName);
                    } else {
                      log("Lets navigate to client home page ");
                      //If Service provider is false then i take user to the  home page
                      Navigator.of(context).pushNamed(HomePage.pageName);
                    }
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Click on save button to save you configurations!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.white,
                      backgroundColor: Colors.red);
                }
              },
              backgroundColor: const Color.fromARGB(255, 14, 63, 103),
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.white),
              ),
            )),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}

class BtnVerifyChooserPage extends ConsumerWidget {
  const BtnVerifyChooserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var phoneNumber = ref.watch(phoneNumberStateProvider);
    return Row(
      children: [
        const Spacer(
          flex: 30,
        ),
        Expanded(
            flex: 40,
            child: FloatingActionButton(
              heroTag: "33",
              onPressed: () {
                FirebaseAuth.instance.verifyPhoneNumber(
                  timeout: const Duration(minutes: 2),
                  phoneNumber: phoneNumber,
                  verificationCompleted: (phoneAuthCredential) {
                    log("Verification Completed");
                  },
                  verificationFailed: (error) {
                    Fluttertoast.showToast(
                        msg: "Verfication Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    log("Verification Failed");
                    if (error.code == 'invalid-phone-number') {
                      log('The provided phone number is not valid.');
                    }
                  },
                  codeSent: (verificationId, forceResendingToken) {
                    log("Verification ID: $verificationId");
                    ref
                        .read(verficationStateProvider.notifier)
                        .onVerficationPassed();
                    Fluttertoast.showToast(
                        msg: "Sending you OTP ...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 12.0);
                    ref
                        .read(phoneNumberStateProvider.notifier)
                        .setVerificationId(verificationId);
                  },
                  codeAutoRetrievalTimeout: (verificationId) {
                    log("Code Auto Retrival called ");
                  },
                );
              },
              backgroundColor: const Color.fromARGB(255, 14, 63, 103),
              child: const Text(
                "Verify",
                style: TextStyle(color: Colors.white),
              ),
            )),
        const Spacer(
          flex: 30,
        ),
      ],
    );
  }
}
