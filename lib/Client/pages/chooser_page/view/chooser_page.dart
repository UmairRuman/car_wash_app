import 'dart:developer';

import 'package:car_wash_app/Client/pages/chooser_page/widgets/main_container.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/user_info.dart';
import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/Collections.dart/user_collection.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/Functions/geo_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChooserPage extends StatefulWidget {
  static const pageName = "/chooserPage";
  const ChooserPage({super.key});

  @override
  State<ChooserPage> createState() => _ChooserPageState();
}

class _ChooserPageState extends State<ChooserPage> {
  UserCollection userCollection = UserCollection();
  @override
  void initState() {
    super.initState();
    getPosition();
  }

  void getPosition() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String userLocation = await userCollection
          .getUserLocation(FirebaseAuth.instance.currentUser!.uid);
      if (userLocation == "") {
        var position = await determinePosition(context);
        currentUserPostion = position;
        log("User Position in IF $currentUserPostion");
      }
    } else {
      var position = await determinePosition(context);
      currentUserPostion = position;
      log("User Position $currentUserPostion");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () async {
              log("Tapped on icon");
              dialogForLogOut(context);
              // If there's no route below the current one, navigate to a new page.
              Fluttertoast.showToast(msg: "Clicked");
            },
            child: const Icon(Icons.arrow_back)),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Stack(children: [
        Column(
          children: [
            const Spacer(
              flex: 40,
            ),
            Expanded(
                flex: 60,
                child: Container(
                  color: Colors.white,
                ))
          ],
        ),
        Positioned(
            height: screenHeight - screenHeight / 5,
            width: screenWidth - screenWidth / 6,
            left: screenWidth / 2 - (screenWidth - screenWidth / 6) / 2,
            top: screenHeight / 2.1 - (screenHeight - screenHeight / 5) / 2,
            child: const ChooserPageMainContainer()),
        Stack(children: [
          Positioned(
              height: screenHeight / 6,
              width: screenWidth / 4,
              left: (screenWidth / 2) - (screenWidth / 4) / 2,
              top: screenHeight / 14 - (screenHeight / 6) / 2,
              child: const ChooserPageUserPic()),
          Positioned(
              height: screenHeight / 9.5,
              width: screenWidth / 9.5,
              left: (screenWidth / 2) + (screenWidth / 20),
              top: screenHeight / 7.5 - (screenHeight / 9) / 2,
              child: const EditIcon())
        ])
      ]),
    ));
  }
}
