import 'package:car_wash_app/Client/pages/sign_up_page/model/model_for_sending_user_info.dart';
import 'package:car_wash_app/Client/pages/twitter_user_email_verification_page.dart/widgets/main_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatelessWidget {
  static const pageName = "/twitterUserEmailVerficationPage";
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    String email;
    String password = "";
    String userName = "";
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var userInfo =
          ModalRoute.of(context)!.settings.arguments as ModelForUserInfo;
      email = userInfo.userEmail;
      password = userInfo.userPassword;
      userName = userInfo.userName;
    } else {
      email = FirebaseAuth.instance.currentUser!.email ?? "";
    }
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: Container(
              height: screenHeight * 0.6,
              width: screenWidth * 0.7,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 25, 94, 151),
                    offset: Offset(8, 8)),
              ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: VerificationPageMainContainer(
                email: email,
                password: password,
                name: userName,
              ))),
    ));
  }
}
