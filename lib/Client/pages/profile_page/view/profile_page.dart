import 'package:car_wash_app/Client/pages/profile_page/controller/profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/containers.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/profile_pic.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/top_container_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  static const pageName = "/profilePage";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userData = ref.read(profileDataStateProvider.notifier).userData;
    var list = [
      userData!.email,
      userData.phoneNumber,
      userData.bonusPoints.toInt().toString(),
      userData.serviceConsumed.toInt().toString()
    ];
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 25,
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    Stack(clipBehavior: Clip.none, children: [
                  TopContainerDecorationProfilePage(
                    userImagePath: userData!.profilePicUrl,
                  ),
                  Positioned(
                      height: constraints.maxHeight / 2,
                      width: constraints.maxWidth / 2,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 2) / 2,
                      bottom: constraints.maxHeight / 8 -
                          (constraints.maxHeight / 2) / 2,
                      child: ProfilePagePic(
                        profileImageUrl: userData.profilePicUrl,
                      )),
                  Positioned(
                      height: constraints.maxHeight / 2.5,
                      width: constraints.maxWidth / 2,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 2) / 2,
                      top: constraints.maxHeight / 3 -
                          (constraints.maxHeight / 2.5) / 2,
                      child: UserName(
                        userName: userData.name,
                      )),
                ]),
              )),
          const Spacer(
            flex: 2,
          ),
          Expanded(
              flex: 55,
              child: ProfileInfoContainersList(
                list: list,
              )),
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
