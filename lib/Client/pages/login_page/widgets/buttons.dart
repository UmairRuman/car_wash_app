import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Client/pages/login_page/controller/sign_in_controller.dart';
import 'package:car_wash_app/Collections.dart/admin_info_collection.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/admin_device_token_collectiion.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/firebase_notifications/notification_service.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/gradients.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:car_wash_app/utils/validations/email_validation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BtnLogin extends ConsumerStatefulWidget {
  const BtnLogin({super.key});

  @override
  ConsumerState<BtnLogin> createState() => _BtnLoginState();
}

class _BtnLoginState extends ConsumerState<BtnLogin>
    with SingleTickerProviderStateMixin {
  AdminInfoCollection adminInfoCollection = AdminInfoCollection();
  NotificationServices notificationServices = NotificationServices();
  AdminDeviceTokenCollection adminDeviceTokenCollection =
      AdminDeviceTokenCollection();
  UserCollection userCollection = UserCollection();

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

  Future<void> onLoginClick(
      BuildContext context, String email, String password) async {
    await animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await animationController.reverse();
    if (loginPageEmailKey.currentState!.validate() &&
        loginPagePasswordKey.currentState!.validate()) {
      try {
        String? trimmedEmail = email.trimEmail();
        informerDialog(context, "Loging in!");
        var userSignInCredentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: trimmedEmail!, password: password);
        User? user = userSignInCredentials.user;

        String userPhoneNumber =
            FirebaseAuth.instance.currentUser!.phoneNumber ?? "";

        if (user != null && userPhoneNumber == "") {
          log("In chooser page Condition");

          Fluttertoast.showToast(
              msg: "Login Successfully",
              textColor: Colors.white,
              backgroundColor: Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
            ChooserPage.pageName,
            (route) => false,
          );
        } else if (user != null &&
            userPhoneNumber != "" &&
            !prefs!.getBool(SharedPreferncesConstants.isServiceProvider)!) {
          Fluttertoast.showToast(
              msg: "Login Successfully",
              textColor: Colors.white,
              backgroundColor: Colors.green);

          Navigator.of(context).pushNamed(
            HomePage.pageName,
          );
        } else if (user != null &&
            userPhoneNumber != "" &&
            prefs!.getBool(SharedPreferncesConstants.isServiceProvider)!) {
          if (mounted) {
            Navigator.of(context).pushNamed(AdminSideHomePage.pageName);
          }
          //When the user is admin and login again may be his token changed so we have to add Token in admin id and also admin device token collection
          String deviceToken = await notificationServices.getTokken();
          adminDeviceTokenCollection.updateSpecificField(
              FirebaseAuth.instance.currentUser!.uid, deviceToken);
          userCollection.updateUserDeviceToken(
              FirebaseAuth.instance.currentUser!.uid, deviceToken);
          adminInfoCollection.updateAdminDeviceToken(
              FirebaseAuth.instance.currentUser!.uid, deviceToken);
          log("Admin Device Token : $deviceToken");

          Fluttertoast.showToast(
              msg: "Login Successfully",
              textColor: Colors.white,
              backgroundColor: Colors.green);
        }
      } catch (e) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Wrong password or email !",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12.0);
      }
    }
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
                  await onLoginClick(
                      context, emailController.text, passwordController.text);
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
