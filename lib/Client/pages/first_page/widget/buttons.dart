import 'package:car_wash_app/Client/pages/login_page/view/login_page.dart';
import 'package:car_wash_app/Client/pages/sign_up_page/view/sign_up_page.dart';
import 'package:flutter/material.dart';

class MainLayoutLoginButton extends StatelessWidget {
  const MainLayoutLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, LoginPage.pageName);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 224, 219, 219),
                  offset: Offset(3, 3),
                  blurRadius: 3)
            ],
            color: Colors.blue,
            border: Border.all(color: Colors.grey.shade500, width: 2),
            borderRadius: BorderRadius.circular(3)),
        child: const Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MainLayoutSignUpButton extends StatelessWidget {
  const MainLayoutSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SignUpPage.pageName);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          color: Color.fromARGB(255, 224, 219, 219),
        ),
        child: const Text(
          "SignUp",
          style: TextStyle(
              color: Color.fromARGB(255, 96, 91, 91),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );
  }
}
