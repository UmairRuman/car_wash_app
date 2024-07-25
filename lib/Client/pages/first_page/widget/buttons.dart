import 'package:car_wash_app/Client/pages/login_page/view/login_page.dart';
import 'package:car_wash_app/Client/pages/sign_up_page/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainLayoutLoginButton extends ConsumerStatefulWidget {
  const MainLayoutLoginButton({super.key});

  @override
  ConsumerState<MainLayoutLoginButton> createState() =>
      _MainLayoutLoginButtonState();
}

class _MainLayoutLoginButtonState extends ConsumerState<MainLayoutLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationForSize;
  Tween<double> tween = Tween(begin: 1.0, end: 0.9);

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animationForSize = tween.animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await animationController.forward();
        await Future.delayed(const Duration(milliseconds: 100));
        await animationController.reverse();
        Navigator.pushNamed(context, LoginPage.pageName);
      },
      child: ScaleTransition(
        scale: animationForSize,
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
      ),
    );
  }
}

class MainLayoutSignUpButton extends ConsumerStatefulWidget {
  const MainLayoutSignUpButton({super.key});

  @override
  ConsumerState<MainLayoutSignUpButton> createState() =>
      _MainLayoutSignUpButtonState();
}

class _MainLayoutSignUpButtonState extends ConsumerState<MainLayoutSignUpButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationForSize;
  Tween<double> tween = Tween(begin: 1.0, end: 0.9);

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animationForSize = tween.animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await animationController.forward();
        await Future.delayed(const Duration(milliseconds: 100));
        await animationController.reverse();
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
