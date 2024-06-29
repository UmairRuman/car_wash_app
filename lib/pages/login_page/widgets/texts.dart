import 'package:car_wash_app/pages/sign_up_page/view/sign_up_page.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class LoginPageTitle extends StatelessWidget {
  const LoginPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

// This is the text for Title of the sign In page like "Sign In"
class LoginTextTitle extends StatelessWidget {
  const LoginTextTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 20,
            child: Row(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w900),
                ),
              ],
            )),
        Spacer(
          flex: 70,
        )
      ],
    );
  }
}

class TextWidgetDontHaveAccount extends StatelessWidget {
  const TextWidgetDontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(
            flex: 38, child: FittedBox(child: Text(stringDontHaveAnAccount))),
        const Spacer(
          flex: 2,
        ),
        Expanded(
            flex: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SignUpPage.pageName);
              },
              child: FittedBox(
                child: Text(
                  stringSignUpPage,
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
        const Spacer(
          flex: 20,
        )
      ],
    );
  }
}
