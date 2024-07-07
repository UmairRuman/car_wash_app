import 'dart:developer';

import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneNumberStateController extends Notifier<String> {
  TextEditingController phoneNumberTEC = TextEditingController();
  TextEditingController otpTEC = TextEditingController();
  String? verificationId;
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
          await user.linkWithCredential(credential);
          log("Phone number linked successfully");

          ref
                  .read(userAdditionStateProvider.notifier)
                  .listOfUserInfo[MapForUserInfo.phoneNumber] =
              "$dialCode${phoneNumberTEC.text}";
          ref
              .read(userAdditionStateProvider.notifier)
              .listOfUserInfo[MapForUserInfo.userName] = user.displayName;
          log("Phone number : ${user.phoneNumber}");
          log('UserGmail : ${user.email}');
        }

        // Handle successful sign-in, e.g., navigate to the next screen
      } catch (e) {
        // Handle error, e.g., show an error message
      }
    } else {
      // Handle case where verificationId is null or OTP is empty
    }
  }
}

final phoneNumberStateProvider =
    NotifierProvider<PhoneNumberStateController, String>(
        PhoneNumberStateController.new);
