import 'package:car_wash_app/Admin/Pages/profile_page/widgets/dialog.dart';
import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/Collections.dart/admin_key_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideEditProfileButton extends ConsumerWidget {
  final String name;
  final String phoneNo;
  final String location;
  const AdminSideEditProfileButton(
      {super.key,
      required this.location,
      required this.name,
      required this.phoneNo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AdminKeyCollection adminKeyCollection = AdminKeyCollection();
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: MaterialButton(
              onPressed: () async {
                showBottomSheetForEnteringOwnerKeyInProfilePage(
                    context, ref, adminKeyCollection, name, phoneNo, location);
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

class AdminSideLogOutProfileButton extends StatelessWidget {
  const AdminSideLogOutProfileButton({super.key});

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
                const Spacer(
                  flex: 30,
                ),
                const Expanded(
                    flex: 20,
                    child: Text(
                      "Do You really want to logout?",
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
