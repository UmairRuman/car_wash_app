import 'package:car_wash_app/Admin/Pages/profile_page/widgets/icons.dart';
import 'package:car_wash_app/Client/pages/profile_page/controller/profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/containers.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/profile_pic.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/top_container_decoration.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  static const pageName = "/profilePage";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    ref.watch(userAdditionStateProvider);
    var userData = ref.read(profileDataStateProvider.notifier).userData;
    var list = [
      userData!.email,
      userData.phoneNumber,
      userData.userLocation,
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
                      height: constraints.maxHeight / 2.5,
                      width: constraints.maxWidth / 2,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 2) / 2,
                      top: constraints.maxHeight / 3 -
                          (constraints.maxHeight / 2.5) / 2,
                      child: UserName(
                        userName: userData.name,
                      )),
                  Positioned(
                      height: constraints.maxHeight / 1.5,
                      width: constraints.maxWidth / 1.5,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 1.5) / 2,
                      bottom: constraints.maxHeight / 7 -
                          (constraints.maxHeight / 1.5) / 2,
                      child: ProfilePagePic(
                        profileImageUrl: userData.profilePicUrl,
                      )),
                  Positioned(
                      height: screenHeight / 8.5,
                      width: screenWidth / 9.5,
                      left: (screenWidth / 2) + (screenWidth / 20),
                      top: screenHeight / 6 - (screenHeight / 8.5) / 2,
                      child: const AdminProfilePageEditIcon())
                ]),
              )),
          const Spacer(
            flex: 5,
          ),
          Expanded(
              flex: 50,
              child: ProfileInfoContainersList(
                list: list,
              )),
          const Spacer(
            flex: 2,
          ),
          Expanded(
              flex: 8,
              child: EditProfileButton(
                location: userData.userLocation,
                name: userData.name,
                phoneNo: userData.phoneNumber,
              )),
          const Expanded(flex: 8, child: LogOutProfileButton()),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    ));
  }
}
