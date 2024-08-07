import 'dart:async';

import 'package:car_wash_app/Client/pages/email_verification_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/widgets/icons.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/widgets/texts.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationPageMainContainer extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  const VerificationPageMainContainer(
      {super.key,
      required this.email,
      required this.name,
      required this.password});

  @override
  State<VerificationPageMainContainer> createState() =>
      _VerificationPageMainContainerState();
}

class _VerificationPageMainContainerState
    extends State<VerificationPageMainContainer> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 10),
      () {},
    );
    createUserAndSendVerification();
  }

  void createUserAndSendVerification() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: widget.email, password: widget.password);
        await FirebaseAuth.instance.currentUser!.updateDisplayName(widget.name);
      } else {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }

      // Start the timer to check for email verification
      timer = Timer.periodic(
        const Duration(seconds: 5),
        (timer) async {
          await FirebaseAuth.instance.currentUser!.reload();
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            timer.cancel();
            Navigator.pushReplacementNamed(context, AuthHandler.pageName);
          }
        },
      );
    } catch (e) {
      // Handle error (e.g., email already in use)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      Navigator.pop(context); // Go back to the sign-up page
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 20,
        ),
        const Expanded(flex: 10, child: EmailIcon()),
        const Spacer(
          flex: 5,
        ),
        const Expanded(flex: 10, child: TextVerifyYourEmail()),
        Expanded(flex: 20, child: TextCheckYourEmail(email: widget.email)),
        const Expanded(flex: 10, child: BtnResendEmail()),
        const Spacer(
          flex: 20,
        ),
      ],
    );
  }
}
