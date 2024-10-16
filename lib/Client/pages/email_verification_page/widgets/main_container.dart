import 'dart:async';
import 'dart:developer';

import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/widgets/icons.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/widgets/texts.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/firebase_notifications/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationPageMainContainer extends ConsumerStatefulWidget {
  const VerificationPageMainContainer({super.key});

  @override
  ConsumerState<VerificationPageMainContainer> createState() =>
      _VerificationPageMainContainerState();
}

class _VerificationPageMainContainerState
    extends ConsumerState<VerificationPageMainContainer>
    with WidgetsBindingObserver {
  NotificationServices notificationServices = NotificationServices();
  UserCollection userCollection = UserCollection();
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

            //Giving a delay a little to allow the dialog to be fully dismissed
            await Future.delayed(const Duration(milliseconds: 300));

            Navigator.pushReplacementNamed(
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
      if (FirebaseAuth.instance.currentUser != null) {
        //If user is not null then we directly send email verfication
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
    } catch (e) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
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
        const Spacer(flex: 5),
        const Expanded(flex: 10, child: EmailIcon()),
        const Spacer(flex: 10),
        const Expanded(flex: 10, child: TextVerifyYourEmail()),
        Expanded(
            flex: 30,
            child: TextCheckYourEmail(
                email: ref
                            .read(userAdditionStateProvider.notifier)
                            .listOfUserInfo[MapForUserInfo.email] ==
                        ""
                    ? FirebaseAuth.instance.currentUser!.email
                    : ref
                        .read(userAdditionStateProvider.notifier)
                        .listOfUserInfo[MapForUserInfo.email])),
        const Expanded(flex: 10, child: BtnResendEmail()),
        const Spacer(flex: 10),
      ],
    );
  }
}
