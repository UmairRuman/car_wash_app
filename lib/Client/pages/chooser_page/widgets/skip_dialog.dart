import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/reseting_all_controllers.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void dialogForSkipProfile(BuildContext context, WidgetRef ref) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Scaffold(
          backgroundColor:
              Colors.transparent, // Makes the scaffold look like a dialog
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Text(
                    "If you want to login as admin, Don't skip profile info",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 2),
                  const Text(
                    "Do you really want to skip profile info?",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.blue,
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () async {
                            UserCollection userCollection = UserCollection();
                            bool isUserInfoProvided =
                                await userCollection.updateServiceProviderInfo(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    true);
                            prefs!.setBool(
                                SharedPreferncesConstants.isUserInfoProvided,
                                true);
                            bool isServiceProvider = ref
                                    .read(userAdditionStateProvider.notifier)
                                    .listOfUserInfo[
                                MapForUserInfo.isServiceProvider];
                            prefs!.setBool(
                                SharedPreferncesConstants.isServiceProvider,
                                isServiceProvider);
                            ref
                                .read(resetingAllControllers.notifier)
                                .resetControllers();
                            Navigator.pop(context);
                            if (isServiceProvider) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AdminSideHomePage.pageName,
                                (route) => false,
                              );
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomePage.pageName,
                                (route) => false,
                              );
                            }
                          },
                          color: Colors.blue,
                          child: const Text("Skip",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
