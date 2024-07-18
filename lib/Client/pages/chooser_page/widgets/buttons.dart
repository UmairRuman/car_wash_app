import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/default_services_controller.dart';
import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/phone_authenticatio_notifier.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BtnContinueChooserPage extends ConsumerWidget {
  const BtnContinueChooserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: FloatingActionButton(
              heroTag: "22",
              onPressed: () {
                //On Click Continue button we will add the user in firestore
                ref.read(userAdditionStateProvider.notifier).addUser();
                //This will trigger when the user is added successfully
                if (ref
                    .read(userAdditionStateProvider.notifier)
                    .isUserDataAdded) {
                  //If Service provider is true then i take user to the admin home page
                  if (ref
                      .read(userAdditionStateProvider.notifier)
                      .listOfUserInfo[MapForUserInfo.isServiceProvider]) {
                    ref
                        .read(defaultServicesStateProvider.notifier)
                        .addDefaultService();
                    Navigator.of(context).pushNamed(AdminSideHomePage.pageName);
                  } else {
                    //If Service provider is false then i take user to the  home page
                    Navigator.of(context).pushNamed(HomePage.pageName);
                  }
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
                    log("Verification Failed");
                    if (error.code == 'invalid-phone-number') {
                      log('The provided phone number is not valid.');
                    }
                  },
                  codeSent: (verificationId, forceResendingToken) {
                    log("Verification ID: $verificationId");
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
