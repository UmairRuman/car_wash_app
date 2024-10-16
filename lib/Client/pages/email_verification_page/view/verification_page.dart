import 'package:car_wash_app/Client/pages/chooser_page/widgets/after_verify_btn_click.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/widgets/main_container.dart';
import 'package:car_wash_app/Client/pages/sign_up_page/model/model_for_sending_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatelessWidget {
  static const pageName = "/emailVerficationPage";
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Email Verification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              {}
            },
            child: const Icon(
              Icons.arrow_back,
            )),
      ),
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
              child: const VerificationPageMainContainer())),
    ));
  }
}
