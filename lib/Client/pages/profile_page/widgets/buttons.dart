import 'package:car_wash_app/Client/pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/edit_profile_page/view/edit_profile_page.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
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
                  ref
                      .read(editProfileInfoProvider.notifier)
                      .onClickEditProfile(name, phoneNo, location);
                  Navigator.of(context)
                      .pushNamed(ClientSideEditProfilePage.pageName);
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

class LogOutProfileButton extends ConsumerWidget {
  const LogOutProfileButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 60,
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
                  dialogForLogOut(context, ref);
                }
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
