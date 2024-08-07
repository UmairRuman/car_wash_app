import 'package:car_wash_app/Client/pages/chooser_page/widgets/after_verify_btn_click.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void showDialogForEnteringOwnerKey(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(flex: 20, child: Text("Enter Admin Key")),
              Expanded(
                flex: 60,
                child: Pinput(
                  errorText: "Your Key is not correct",
                  defaultPinTheme: defaultPinTheme,
                  animationCurve: Curves.bounceOut,
                  showCursor: false,
                  length: 6,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  controller: TextEditingController(),
                ),
              ),
              Expanded(
                  flex: 20,
                  child: Row(
                    children: [
                      const Spacer(
                        flex: 20,
                      ),
                      Expanded(
                          flex: 60,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Colors.amber,
                            child: const Text("Enter"),
                          )),
                      const Spacer(
                        flex: 20,
                      )
                    ],
                  ))
            ],
          ),
        ),
      );
    },
  );
}
