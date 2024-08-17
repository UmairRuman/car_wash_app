import 'package:car_wash_app/Client/pages/edit_profile_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/edit_profile_page/widgets/text_editting_controllers.dart';
import 'package:flutter/material.dart';

class ClientSideEditProfilePage extends StatelessWidget {
  static const String pageName = "/clientSideEditProfilePage";
  const ClientSideEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              Expanded(flex: 16, child: EditNameTEC()),
              Expanded(flex: 16, child: EditLocationTEC()),
              Expanded(flex: 16, child: EditPhoneNoTEC()),
              Expanded(flex: 10, child: ButtonUpdateUserInfo()),
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
