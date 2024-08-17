import 'dart:developer';

import 'package:bcrypt/bcrypt.dart';
import 'package:car_wash_app/Admin/Pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:car_wash_app/Admin/Pages/edit_profile_page/view/edit_profile_page.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/controller/key_state_controller.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/after_verify_btn_click.dart';
import 'package:car_wash_app/Collections.dart/admin_key_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

void showBottomSheetForEnteringOwnerKeyInProfilePage(
    BuildContext context,
    WidgetRef ref,
    AdminKeyCollection adminKeyCollection,
    String name,
    String phoneNo,
    String location) {
  bool isWrongKey = false;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 20,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Enter Admin Key",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Pinput(
                    forceErrorState: isWrongKey,
                    errorText: "Your Key is not correct",
                    defaultPinTheme: defaultPinTheme,
                    animationCurve: Curves.bounceOut,
                    showCursor: true,
                    length: 6,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    controller: ref.read(keyStateProvider.notifier).keyTEC,
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: Row(
                  children: [
                    const Spacer(flex: 10),
                    Expanded(
                      flex: 30,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.blue,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(flex: 20),
                    Expanded(
                      flex: 30,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {});
                          var adminKey = await adminKeyCollection.getAdminKey();
                          String enteredPin =
                              ref.read(keyStateProvider.notifier).keyTEC.text;
                          log("Entered Pin: $enteredPin");
                          log("Admin Key Pin: ${adminKey.pin}");

                          if (BCrypt.checkpw(enteredPin, adminKey.pin)) {
                            Navigator.of(context).pop();
                            dialogForLoading(context);
                            await ref
                                .read(adminSideEditProfileInfoProvider.notifier)
                                .onClickEditProfile(
                                    name,
                                    ref
                                        .read(keyStateProvider.notifier)
                                        .keyTEC
                                        .text,
                                    phoneNo,
                                    location);
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(AdminSideEditProfilePage.pageName);

                            log("Both keys matched");
                            isWrongKey = false;
                          } else {
                            log("Keys do not match");
                            setState(() {
                              isWrongKey = true;
                            });
                          }
                        },
                        color: Colors.blue,
                        child: const Text(
                          "Enter",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(flex: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void dialogForLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 100,
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Center(
              child: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text(
                "Checking configurations ",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          )),
        ),
      );
    },
  );
}
