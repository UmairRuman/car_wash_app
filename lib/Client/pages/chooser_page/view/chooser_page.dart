import 'package:car_wash_app/Client/pages/chooser_page/widgets/main_container.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/user_info.dart';
import 'package:flutter/material.dart';

class ChooserPage extends StatelessWidget {
  static const pageName = "/chooserPage";
  const ChooserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Stack(children: [
        Column(
          children: [
            const Spacer(
              flex: 40,
            ),
            Expanded(
                flex: 60,
                child: Container(
                  color: Colors.white,
                ))
          ],
        ),
        Positioned(
            height: screenHeight - screenHeight / 5,
            width: screenWidth - screenWidth / 6,
            left: screenWidth / 2 - (screenWidth - screenWidth / 6) / 2,
            top: screenHeight / 2 - (screenHeight - screenHeight / 5) / 2,
            child: const ChooserPageMainContainer()),
        Stack(children: [
          Positioned(
              height: screenHeight / 6,
              width: screenWidth / 4,
              left: (screenWidth / 2) - (screenWidth / 4) / 2,
              top: screenHeight / 9.5 - (screenHeight / 6) / 2,
              child: const ChooserPageUserPic()),
          Positioned(
              height: screenHeight / 9.5,
              width: screenWidth / 9.5,
              left: (screenWidth / 2) + (screenWidth / 20),
              top: screenHeight / 7.5 - (screenHeight / 9) / 2,
              child: const EditIcon())
        ])
      ]),
    ));
  }
}
