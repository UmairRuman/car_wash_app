import 'package:car_wash_app/Admin/Pages/profile_page/widgets/dialog.dart';
import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/Collections.dart/admin_key_collection.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
                  showBottomSheetForEnteringOwnerKeyInProfilePage(context, ref,
                      adminKeyCollection, name, phoneNo, location);
                }
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
