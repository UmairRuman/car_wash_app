import 'dart:developer';

import 'package:car_wash_app/Client/pages/sign_up_page/controller/sign_up_page_controller.dart';
import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/gradients.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnCreateAccount extends ConsumerWidget {
  const BtnCreateAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailController = ref.read(signUpPageProvider.notifier).emailTEC;
    var passWordController = ref.read(signUpPageProvider.notifier).passwordTEC;
    var nameController = ref.read(signUpPageProvider.notifier).nameTEC;
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(
          flex: 50,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () async {
              if (signUpPagePasswordKey.currentState!.validate() &&
                  signUpPageEmailKey.currentState!.validate() &&
                  signUpPageNameKey.currentState!.validate()) {
                UserCredential credentials = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passWordController.text);

                User? user = credentials.user;

                if (FirebaseAuth.instance.currentUser != null) {
                  await FirebaseAuth.instance.currentUser!
                      .updateDisplayName(nameController.text);

                  log(FirebaseAuth.instance.currentUser?.displayName ??
                      'No Name');
                  log('[Updated successfully]');
                  // await user.updateProfile(displayName: nameController.text);
                  // log("Name : ${user.displayName}");
                  // await user.reload();
                  // user = FirebaseAuth.instance.currentUser;
                }
              }
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  gradient: gradientForButton),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                stringCreateAccount,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 25,
        ),
      ],
    );
  }
}
