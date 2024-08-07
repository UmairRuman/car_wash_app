import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BtnResendEmail extends StatelessWidget {
  const BtnResendEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      },
      color: const Color.fromARGB(255, 23, 79, 125),
      child: const Text(
        "Resend Email",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
