import 'dart:developer';

import 'package:bcrypt/bcrypt.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/color_controller.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/after_verify_btn_click.dart';
import 'package:car_wash_app/Collections.dart/admin_key_collection.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

void showDialogForEnteringOwnerKey(BuildContext context, WidgetRef ref,
    AdminKeyCollection adminKeyCollection) {
  TextEditingController textEditingController = TextEditingController();

  bool isWrongKey = false;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          child: StatefulBuilder(
            builder: (context, setState) => Column(
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
                      controller: textEditingController,
                    ),
                  ),
                ),
                // if(isWrongKey)
                //  Expanded(flex: 10, child: Text(data)),
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
                            var adminKey =
                                await adminKeyCollection.getAdminKey();
                            String enteredPin = textEditingController.text;
                            log("Entered Pin: $enteredPin");
                            log("Admin Key Pin: ${adminKey.pin}");

                            if (BCrypt.checkpw(enteredPin, adminKey.pin)) {
                              log("Both keys matched");
                              isWrongKey = false;
                              Navigator.of(context).pop();
                              ref
                                  .read(colorNotifierProvider.notifier)
                                  .onClickOnAttendentChoice();
                              ref
                                      .read(userAdditionStateProvider.notifier)
                                      .listOfUserInfo[
                                  MapForUserInfo.isServiceProvider] = true;
                            } else {
                              log("Keys do not match");
                              setState(() {
                                isWrongKey = true;
                              });
                            }
                          },
                          color: Colors.blue,
                          child: const Text("Enter",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const Spacer(flex: 10),
                    ],
                  ),
                ),
                const Spacer(flex: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}
