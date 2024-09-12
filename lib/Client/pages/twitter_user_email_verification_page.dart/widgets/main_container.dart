import 'dart:async';
import 'dart:developer';

import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/twitter_user_email_verification_page.dart/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/twitter_user_email_verification_page.dart/widgets/icons.dart';
import 'package:car_wash_app/Client/pages/twitter_user_email_verification_page.dart/widgets/texts.dart';

import 'package:car_wash_app/Dialogs/dialogs.dart';
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
    extends State<VerificationPageMainContainer> with WidgetsBindingObserver {
  late Timer _timer;
  bool _isVerificationDialogVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    createUserAndSendVerification();
    _startVerificationCheckTimer();
  }

  @override
  void dispose() {
    log("dispose called");
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startVerificationCheckTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        await _checkEmailVerified();
      },
    );
  }

  Future<void> _checkEmailVerified() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
        _timer.cancel();

        if (!_isVerificationDialogVisible) {
          setState(() {
            _isVerificationDialogVisible = true;
          });

          // Show a dialog that informs the user of successful verification
          informerDialog(context, "Logging in");

          await Future.delayed(const Duration(seconds: 3));

          if (mounted) {
            Navigator.pop(context); // Close the dialog

            // Delay a little to allow the dialog to be fully dismissed
            await Future.delayed(const Duration(milliseconds: 300));

            Navigator.pushNamed(
              context,
              ChooserPage.pageName,
            );
          }
        }
      }
    } catch (e) {
      log("Error during email verification check: $e");
    }
  }

  Future<void> createUserAndSendVerification() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: widget.email, password: widget.password);
        await FirebaseAuth.instance.currentUser!.updateDisplayName(widget.name);
      }
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        Navigator.pop(context); // Go back to the sign-up page
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // When the app is resumed, check if the email has been verified
      _checkEmailVerified();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 20),
        const Expanded(flex: 10, child: EmailIcon()),
        const Spacer(flex: 5),
        const Expanded(flex: 10, child: TextVerifyYourEmail()),
        Expanded(flex: 20, child: TextCheckYourEmail(email: widget.email)),
        const Expanded(flex: 10, child: BtnResendEmail()),
        const Spacer(flex: 20),
      ],
    );
  }
}
