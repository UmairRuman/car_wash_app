import 'dart:developer';

import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/phone_authenticatio_notifier.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              onPressed: () async {
                ref.read(userAdditionStateProvider.notifier).addUser();
                if (ref
                    .read(userAdditionStateProvider.notifier)
                    .isUserDataAdded) {
                  Navigator.of(context).pushNamed(HomePage.pageName);
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
