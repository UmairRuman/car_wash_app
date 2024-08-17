import 'package:car_wash_app/Client/pages/login_page/view/login_page.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

// This is the text for Title of the sign page like "Sign Up"
class TextTitle extends StatelessWidget {
  const TextTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Sign Up",
      style: TextStyle(
          color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
    );
  }
}

class TextWidgetAlreadyHaveAnAccount extends StatelessWidget {
  const TextWidgetAlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 20,
        ),
        const Expanded(
            flex: 43,
            child: FittedBox(child: Text(stringAlreadyHaveAnAccount))),
        const Spacer(
          flex: 2,
        ),
        Expanded(
            flex: 14,
            child: TouchRippleEffect(
              rippleColor: Colors.lightBlue,
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginPage.pageName);
              },
              child: FittedBox(
                child: Text(
                  stringSignInPage,
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
        const Spacer(
          flex: 21,
        )
      ],
    );
  }
}
