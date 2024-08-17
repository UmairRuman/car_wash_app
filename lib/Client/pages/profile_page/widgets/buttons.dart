import 'dart:developer';

import 'package:car_wash_app/Client/pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/edit_profile_page/view/edit_profile_page.dart';
import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileButton extends ConsumerWidget {
  final String name;
  final String phoneNo;
  final String location;
  const EditProfileButton(
      {super.key,
      required this.location,
      required this.name,
      required this.phoneNo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: MaterialButton(
              onPressed: () {
                log(name);
                log(phoneNo);
                log(location);

                ref
                    .read(editProfileInfoProvider.notifier)
                    .onClickEditProfile(name, phoneNo, location);
                Navigator.of(context)
                    .pushNamed(ClientSideEditProfilePage.pageName);
              },
              color: Colors.blue,
              child: const Text(
                "Edit Profile",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}

class LogOutProfileButton extends StatelessWidget {
  const LogOutProfileButton({super.key});

  void dialogForLogOut(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                const Expanded(
                    flex: 50,
                    child: Text(
                      "Are You really want to logout?",
                      textAlign: TextAlign.center,
                    )),
                const Spacer(
                  flex: 10,
                ),
                Expanded(
                    flex: 30,
                    child: Row(
                      children: [
                        const Spacer(
                          flex: 15,
                        ),
                        Expanded(
                            flex: 30,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.blue,
                              child: const Text("No",
                                  style: TextStyle(color: Colors.white)),
                            )),
                        const Spacer(
                          flex: 10,
                        ),
                        Expanded(
                            flex: 30,
                            child: MaterialButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                SchedulerBinding.instance.addPostFrameCallback(
                                  (timeStamp) {
                                    Navigator.of(context).pushReplacementNamed(
                                        FirstPage.pageName);
                                  },
                                );
                              },
                              color: Colors.blue,
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                        const Spacer(
                          flex: 15,
                        ),
                      ],
                    )),
                const Spacer(
                  flex: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 60,
            child: MaterialButton(
              onPressed: () {
                dialogForLogOut(context);
              },
              color: Colors.blue,
              child: const Text(
                "Log Out",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )),
        const Spacer(
          flex: 20,
        ),
      ],
    );
  }
}
