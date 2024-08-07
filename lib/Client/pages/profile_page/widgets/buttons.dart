import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/Client/pages/login_page/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: MaterialButton(
              onPressed: () {},
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
                FirebaseAuth.instance.signOut();
                SchedulerBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    Navigator.of(context).pushNamed(FirstPage.pageName);
                  },
                );
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
