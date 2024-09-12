import 'package:car_wash_app/Admin/Pages/edit_profile_page/widgets/buttons.dart';
import 'package:car_wash_app/Admin/Pages/edit_profile_page/widgets/text_editting_controllers.dart';
import 'package:car_wash_app/Client/pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideEditProfilePage extends ConsumerWidget {
  static const String pageName = "/adminSideEditProfilePage";
  const AdminSideEditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 89, 171, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 89, 171, 239),
        leading: InkWell(
            onTap: () {
              ref.read(bottomStateProvider.notifier).currentNavigationState(2);
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          height: screenHeight * 0.6,
          width: screenWidth * 0.8,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 25, 94, 151), offset: Offset(8, 8)),
          ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              Expanded(
                  flex: 10,
                  child: Text(
                    "Enter updated Info",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )),
              Expanded(flex: 16, child: AdminEditNameTEC()),
              Expanded(flex: 16, child: AdminEditPasswordTEC()),
              Expanded(flex: 16, child: AdminEditLocationTEC()),
              Expanded(flex: 16, child: AdminEditPhoneNoTEC()),
              Expanded(flex: 10, child: AdminButtonUpdateUserInfo()),
              Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
