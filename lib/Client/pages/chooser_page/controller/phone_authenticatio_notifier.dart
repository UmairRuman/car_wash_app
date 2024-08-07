import 'dart:developer';

import 'package:car_wash_app/Client/pages/chooser_page/controller/otp_verification_state_notifier.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/verification_state_notifier.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhoneNumberStateController extends Notifier<String> {
  TextEditingController phoneNumberTEC = TextEditingController();
  TextEditingController otpTEC = TextEditingController();
  String? verificationId;
  bool isVerficationPassed = false;
  String? dialCode;

  @override
  String build() {
    return "";
  }

  void onChangePhoneNo(String number) {
    state = number;
  }

  void setVerificationId(String id) {
    verificationId = id;
    isVerficationPassed = true;
  }

  Future<void> verifyOtp() async {
    if (verificationId != null && otpTEC.text.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: otpTEC.text,
        );
        log("Got Credentials");
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          log("User is not null");
          var linqCredentials = await user.linkWithCredential(credential);
          log("Phone number linked successfully");

          ref.read(otpVerficationProvider.notifier).onVerifiedOtp();

          ref
                  .read(userAdditionStateProvider.notifier)
                  .listOfUserInfo[MapForUserInfo.phoneNumber] =
              "$dialCode${phoneNumberTEC.text}";
          ref
              .read(userAdditionStateProvider.notifier)
              .listOfUserInfo[MapForUserInfo.userName] = user.displayName;
          log('UserGmail : ${user.email}');
        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'credential-already-in-use') {
            Fluttertoast.showToast(
                msg: "This phone number is already registered.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white,
                backgroundColor: Colors.red);
          } else {
            if (!ref.read(otpVerficationProvider.notifier).isOtpVerified) {
              ref.read(verficationStateProvider.notifier).onVerficationPassed();
            }
            Fluttertoast.showToast(
              msg: "Wrong key or your phone number is already registered.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );

            log('Error: ${e.message}');
          }
        } else {
          log("Second Else");
          // Handle other types of exceptions
          log('Error: ${e.toString()}');
        }
      }
    } else {
      // Handle case where verificationId is null or OTP is empty
    }
  }
}

final phoneNumberStateProvider =
    NotifierProvider<PhoneNumberStateController, String>(
        PhoneNumberStateController.new);
