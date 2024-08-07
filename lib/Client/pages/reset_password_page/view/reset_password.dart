import 'package:car_wash_app/Client/pages/reset_password_page/widgets/reset_page_main_Container.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  static const pageName = "/resetPassword";
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back)),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Center(
          child: Container(
              height: screenHeight * 0.6,
              width: screenWidth * 0.8,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 25, 94, 151),
                    offset: Offset(8, 8)),
              ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: const ResetPageMainContainer())),
    ));
  }
}
