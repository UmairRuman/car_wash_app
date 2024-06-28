import 'package:car_wash_app/pages/sign_up_page/widgets/buttons.dart';
import 'package:car_wash_app/pages/sign_up_page/widgets/checkBox.dart';
import 'package:car_wash_app/pages/sign_up_page/widgets/lower_container.dart';
import 'package:car_wash_app/pages/sign_up_page/widgets/text.dart';
import 'package:car_wash_app/pages/sign_up_page/widgets/text_fields.dart';
import 'package:car_wash_app/pages/sign_up_page/widgets/top_container_painter.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 25,
                child: CustomPaint(
                  painter: TopContainerPainter(),
                  child: Container(
                    alignment: Alignment.center + (Alignment.center / 2),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 130),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 10, child: TextFieldName()),
              const Expanded(flex: 10, child: TextFieldEmail()),
              const Expanded(flex: 10, child: TextFieldPassword()),
              const Expanded(flex: 5, child: CheckBoxTermsAndCondition()),
              const Expanded(flex: 10, child: BtnCreateAccount()),
              const Expanded(flex: 10, child: TextWidgetAlreadyHaveAnAccount()),
              Expanded(
                flex: 20,
                child: ClipPath(
                    clipper: LowerContainerPainter(),
                    child: Container(
                      color: Colors.blue,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
