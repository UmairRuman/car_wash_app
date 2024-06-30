import 'package:car_wash_app/pages/profile_page/widgets/buttons.dart';
import 'package:car_wash_app/pages/profile_page/widgets/containers.dart';
import 'package:car_wash_app/pages/profile_page/widgets/profile_pic.dart';
import 'package:car_wash_app/pages/profile_page/widgets/top_container_decoration.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const pageName = "/profilePage";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 25,
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    Stack(clipBehavior: Clip.none, children: [
                  const TopContainerDecorationProfilePage(),
                  Positioned(
                      height: constraints.maxHeight / 2.5,
                      width: constraints.maxWidth / 2.5,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 2.5) / 2,
                      bottom: constraints.maxHeight / 8 -
                          (constraints.maxHeight / 2.5) / 2,
                      child: const ProfilePagePic()),
                  Positioned(
                      height: constraints.maxHeight / 2.5,
                      width: constraints.maxWidth / 2,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 2) / 2,
                      top: constraints.maxHeight / 2 -
                          (constraints.maxHeight / 2.5) / 2,
                      child: const UserName()),
                ]),
              )),
          const Spacer(
            flex: 2,
          ),
          const Expanded(flex: 55, child: ProfileInfoContainersList()),
          const Expanded(flex: 8, child: EditProfileButton()),
          const Spacer(
            flex: 2,
          ),
          const Expanded(flex: 8, child: LogOutProfileButton()),
        ],
      ),
    ));
  }
}
