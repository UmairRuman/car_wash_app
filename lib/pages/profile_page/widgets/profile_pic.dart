import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class ProfilePagePic extends StatelessWidget {
  const ProfilePagePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(profilePic), fit: BoxFit.cover)),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Umair Ruman",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
