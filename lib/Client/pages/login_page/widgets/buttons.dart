import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Client/pages/login_page/controller/sign_in_controller.dart';
import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/gradients.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnLogin extends ConsumerWidget {
  const BtnLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailController = ref.read(signInInfoProvider.notifier).emailSignInTEC;
    var passwordController =
        ref.read(signInInfoProvider.notifier).passwordSignInTEC;
    ref.read(signInInfoProvider.notifier).emailSignInTEC;
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(
          flex: 50,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () async {
              {
                if (loginPageEmailKey.currentState!.validate() &&
                    loginPagePasswordKey.currentState!.validate()) {
                  var userSignInCredentials = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                  User? user = userSignInCredentials.user;
                  if (user != null) {
                    SchedulerBinding.instance.addPostFrameCallback(
                      (timeStamp) {
                        Navigator.of(context).pushNamed(HomePage.pageName);
                      },
                    );
                  }
                }
              }
            },
            backgroundColor:
                Colors.transparent, // Set FAB background color to transparent
            elevation: 0, // Remove FAB elevation
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  gradient: gradientForButton),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: const Text(
                stringLogin,
                style: TextStyle(color: Colors.white),
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
