import 'dart:developer';

import 'package:car_wash_app/Client/pages/reset_password_page/model/text_controller.dart';
import 'package:car_wash_app/utils/validations/email_validation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BtnResetPassword extends ConsumerWidget {
  const BtnResetPassword({super.key});

  void onClickResetPassword(String state, BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult[0] == ConnectivityResult.none) {
      // No internet connection
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      bool validEmail = state.isValidEmail();
      log(validEmail.toString(), name: "Valid Email");
      if (validEmail) {
        FirebaseAuth.instance.sendPasswordResetEmail(email: state);
        Fluttertoast.showToast(
            msg: "Sending you email",
            backgroundColor: Colors.green,
            textColor: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(emailTextProvider);
    return MaterialButton(
      onPressed: () {},
      color: const Color.fromARGB(255, 23, 79, 125),
      child: const Text(
        "Reset Password",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
