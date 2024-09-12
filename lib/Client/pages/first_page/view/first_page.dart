import 'package:car_wash_app/Client/pages/first_page/widget/buttons.dart';
import 'package:car_wash_app/Client/pages/first_page/widget/clipped_container.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  static const String pageName = "/";
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Center(
          child: Stack(children: [
            Column(
              children: [
                Expanded(
                    flex: 70,
                    child: ClipPath(
                      clipper: ClipedDecoratedContainer(),
                      child: Container(
                        color: const Color.fromARGB(255, 243, 238, 238),
                      ),
                    )),
                const Spacer(
                  flex: 13,
                ),
                const Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      Spacer(
                        flex: 10,
                      ),
                      Expanded(flex: 35, child: MainLayoutLoginButton()),
                      Spacer(
                        flex: 5,
                      ),
                      Expanded(flex: 35, child: MainLayoutSignUpButton()),
                      Spacer(
                        flex: 10,
                      )
                    ],
                  ),
                ),
                const Spacer(
                  flex: 10,
                )
              ],
            ),
            Positioned(
                width: 500,
                height: 500,
                left: screenWidth / 2 - 250,
                top: screenHeight / 2 - 250,
                child: Image.asset(carWashMainScreenLogo)),
            Positioned(
                width: 250,
                height: 250,
                left: screenWidth / 2 - 125,
                top: screenHeight / 9 - 125,
                child: const FittedBox(
                  child: Text(
                    stringBookYourCarWash,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Positioned(
                width: 300,
                height: 300,
                left: screenWidth / 2 - 150,
                top: screenHeight / 3 - 150,
                child: const Text(
                  "The Car Wash app is your mobile ticket to a sparkling clean car.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
