import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class ProfilePagePic extends StatelessWidget {
  final String profileImageUrl;
  const ProfilePagePic({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(profileImageUrl), fit: BoxFit.fill)),
    );
  }
}

class UserName extends StatelessWidget {
  final String userName;
  const UserName({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        userName,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
