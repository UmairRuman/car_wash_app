import 'package:car_wash_app/Admin/Pages/profile_page/widgets/buttons.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/widgets/containers.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/widgets/icons.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/widgets/profile_pic.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/profile_info.dart';
import 'package:car_wash_app/Client/pages/profile_page/controller/profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/profile_page/widgets/top_container_decoration.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideProfilePage extends ConsumerWidget {
  static const pageName = "/adminSideProfilePage";
  const AdminSideProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(userAdditionStateProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var userData = ref.read(profileDataStateProvider.notifier).userData;
    var list = [
      userData!.email,
      (state as AddittionLoadedState).user.phoneNumber,
      state.user.userLocation,
      userData.serviceConsumed.toInt().toString()
    ];
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              flex: 25,
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    Stack(clipBehavior: Clip.none, children: [
                  TopContainerDecorationProfilePage(
                    userImagePath: userData.profilePicUrl,
                  ),
                  Positioned(
                      height: constraints.maxHeight / 2.5,
                      width: constraints.maxWidth / 2,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 2) / 2,
                      top: constraints.maxHeight / 3 -
                          (constraints.maxHeight / 2.5) / 2,
                      child: UserNameText(
                        userName: state.user.name,
                      )),
                  Positioned(
                      height: constraints.maxHeight / 1.5,
                      width: constraints.maxWidth / 1.5,
                      left: constraints.maxWidth / 2 -
                          (constraints.maxWidth / 1.5) / 2,
                      bottom: constraints.maxHeight / 8 -
                          (constraints.maxHeight / 1.5) / 2,
                      child: AdminSideProfilePagePic(
                        profileImageUrl: userData.profilePicUrl,
                      )),
                  Positioned(
                      height: screenHeight / 9.5,
                      width: screenWidth / 9.5,
                      left: (screenWidth / 2) + (screenWidth / 20),
                      top: screenHeight / 6 - (screenHeight / 9.5) / 2,
                      child: const AdminProfilePageEditIcon())
                ]),
              )),
          const Spacer(
            flex: 9,
          ),
          Expanded(
              flex: 45,
              child: AdminSideProfileInfoContainersList(
                list: list,
              )),
          Expanded(
              flex: 8,
              child: AdminSideEditProfileButton(
                location: state.user.userLocation,
                name: state.user.name,
                phoneNo: state.user.phoneNumber,
              )),
          const Spacer(
            flex: 2,
          ),
          const Expanded(flex: 8, child: AdminSideLogOutProfileButton()),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    ));
  }
}
