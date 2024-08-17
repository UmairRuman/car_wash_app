import 'dart:developer';

import 'package:car_wash_app/Client/pages/reset_password_page/model/text_controller.dart';
import 'package:car_wash_app/utils/validations/email_validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnResetPassword extends ConsumerWidget {
  const BtnResetPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(emailTextProvider);
    return MaterialButton(
      onPressed: () {
        bool validEmail = state.isValidEmail();
        log(validEmail.toString(), name: "Valid Email");
        if (validEmail) {
          log("Condtion Satified");
          FirebaseAuth.instance.sendPasswordResetEmail(email: state);
        }
      },
      color: const Color.fromARGB(255, 23, 79, 125),
      child: const Text(
        "Reset Password",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
