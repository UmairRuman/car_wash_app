import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Client/pages/login_page/controller/sign_in_controller.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/gradients.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BtnLogin extends ConsumerStatefulWidget {
  const BtnLogin({super.key});

  @override
  ConsumerState<BtnLogin> createState() => _BtnLoginState();
}

class _BtnLoginState extends ConsumerState<BtnLogin>
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
    var emailController = ref.read(signInInfoProvider.notifier).emailSignInTEC;
    var passwordController =
        ref.read(signInInfoProvider.notifier).passwordSignInTEC;

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
                {
                  await animationController.forward();
                  await Future.delayed(const Duration(milliseconds: 100));
                  await animationController.reverse();
                  if (loginPageEmailKey.currentState!.validate() &&
                      loginPagePasswordKey.currentState!.validate()) {
                    try {
                      var userSignInCredentials = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      User? user = userSignInCredentials.user;
                      await ref
                          .read(userAdditionStateProvider.notifier)
                          .getUserPhoneNumber(
                              FirebaseAuth.instance.currentUser!.uid);
                      String userPhoneNumber = ref
                          .read(userAdditionStateProvider.notifier)
                          .phoneNumberForLogin;
                      if (user != null && userPhoneNumber != "") {
                        SchedulerBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            Navigator.of(context).pushNamed(HomePage.pageName);
                          },
                        );
                      } else if (user != null && userPhoneNumber == "") {
                        SchedulerBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            Navigator.of(context)
                                .pushNamed(ChooserPage.pageName);
                          },
                        );
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "Wrong password or email ! ${e.toString()}",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 12.0);
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: const Text(
                  stringLogin,
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
