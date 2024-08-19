import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/default_services_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/phone_authenticatio_notifier.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/save_data_notifier.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/verification_state_notifier.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class BtnContinueChooserPage extends ConsumerStatefulWidget {
  const BtnContinueChooserPage({super.key});

  @override
  ConsumerState<BtnContinueChooserPage> createState() =>
      _BtnContinueChooserPageState();
}

class _BtnContinueChooserPageState extends ConsumerState<BtnContinueChooserPage>
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

  void myDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitWanderingCubes(
                  color: Colors.white,
                  size: 60,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Wait, Setting environment for you ... ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void onClickContinueButton(bool userSavedState) async {
    await animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await animationController.reverse();
    if (userSavedState) {
      log("Is User Data Added Continue ${ref.read(userAdditionStateProvider.notifier).isUserDataAdded}");
      if (ref.read(userAdditionStateProvider.notifier).isUserDataAdded) {
        //If Service provider is true then i take user to the admin home page
        if (ref
            .read(userAdditionStateProvider.notifier)
            .listOfUserInfo[MapForUserInfo.isServiceProvider]) {
          log("Lets navigate to Admin home page ");

          log("Admin Key is null");
          myDialog(context);

          await ref
              .read(previousServiceStateProvider.notifier)
              .addDefaultPreviousWorkCategories();
          await ref
              .read(defaultServicesStateProvider.notifier)
              .addDefaultService();
          Navigator.of(context).pop();

          Navigator.of(context).pushNamed(AdminSideHomePage.pageName);
        } else {
          log("Lets navigate to client home page ");
          //If Service provider is false then i take user to the  home page
          Navigator.of(context).pushNamed(HomePage.pageName);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Click on save button to save you configurations!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool userSaveState = ref.watch(userSaveStateProvider);
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: ScaleTransition(
              scale: animationForSize,
              child: FloatingActionButton(
                heroTag: "22",
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
                    onClickContinueButton(userSaveState);
                  }
                },
                backgroundColor: const Color.fromARGB(255, 14, 63, 103),
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}

class BtnVerifyChooserPage extends ConsumerWidget {
  const BtnVerifyChooserPage({super.key});

  //Function
  void onClickVerifyButton(
      WidgetRef ref, BuildContext context, String phoneNumber) {
    FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(minutes: 2),
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        log("Verification Completed");
      },
      verificationFailed: (error) {
        Fluttertoast.showToast(
            msg: "Verfication Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        log("Verification Failed");
        if (error.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid, phone number!")));
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        log("Verification ID: $verificationId");
        ref.read(verficationStateProvider.notifier).onVerficationPassed();
        Fluttertoast.showToast(
            msg: "Sending you OTP ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12.0);
        ref
            .read(phoneNumberStateProvider.notifier)
            .setVerificationId(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log("Code Auto Retrival called ");
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var phoneNumber = ref.watch(phoneNumberStateProvider);

    return Row(
      children: [
        const Spacer(
          flex: 30,
        ),
        Expanded(
          flex: 40,
          child: MaterialButton(
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
                onClickVerifyButton(ref, context, phoneNumber);
              }
            },
          ),
        ),
        const Spacer(
          flex: 30,
        ),
      ],
    );
  }
}
