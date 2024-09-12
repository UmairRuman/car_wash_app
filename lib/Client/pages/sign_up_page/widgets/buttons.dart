import 'package:car_wash_app/Client/pages/email_verification_page/view/verification_page.dart';
import 'package:car_wash_app/Client/pages/sign_up_page/controller/sign_up_page_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/gradients.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:car_wash_app/utils/validations/email_validation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnCreateAccount extends ConsumerStatefulWidget {
  const BtnCreateAccount({super.key});

  @override
  ConsumerState<BtnCreateAccount> createState() => _BtnCreateAccountState();
}

class _BtnCreateAccountState extends ConsumerState<BtnCreateAccount>
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

  Future<void> onClickSignUpButton(
      String email, String userName, String userPassword) async {
    await animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await animationController.reverse();

    if (signUpPagePasswordKey.currentState!.validate() &&
        signUpPageEmailKey.currentState!.validate() &&
        signUpPageNameKey.currentState!.validate()) {
      String trimmedEmail = email.trimEmail()!;
      try {
        informerDialog(context, "Creating Account");
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: trimmedEmail, password: userPassword);
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseAuth.instance.currentUser!.updateDisplayName(userName);
        }
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushReplacementNamed(EmailVerificationPage.pageName);
      } catch (signUpError) {
        // if (signUpError is PlatformException) {
        //   if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        //     /// `foo@bar.com` has alread been registered.
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Email is already registered! ${signUpError.toString()}")));
        // }
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var emailController = ref.read(signUpPageProvider.notifier).emailTEC;
    var passWordController = ref.read(signUpPageProvider.notifier).passwordTEC;
    var nameController = ref.read(signUpPageProvider.notifier).nameTEC;
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(
          flex: 50,
          child: ScaleTransition(
            scale: animationForSize,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () async {
                final connectivityResult =
                    await Connectivity().checkConnectivity();
                if (connectivityResult[0] == ConnectivityResult.none) {
                  // No internet connection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No internet connection'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  await onClickSignUpButton(emailController.text,
                      nameController.text, passWordController.text);
                }
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    gradient: gradientForButton),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: const Text(
                  stringCreateAccount,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 25,
        ),
      ],
    );
  }
}
