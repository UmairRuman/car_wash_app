import 'package:flutter/material.dart';

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
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue,
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
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue,
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
