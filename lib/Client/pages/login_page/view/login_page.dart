import 'package:car_wash_app/Client/pages/login_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/login_page/widgets/icons.dart';
import 'package:car_wash_app/Client/pages/login_page/widgets/text_fields.dart';
import 'package:car_wash_app/Client/pages/login_page/widgets/texts.dart';
import 'package:car_wash_app/utils/global_keys.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String pageName = "/loginPage";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            const Spacer(
              flex: 10,
            ),
            const Expanded(flex: 12, child: LoginPageTitle()),
            const Spacer(
              flex: 5,
            ),
            Expanded(
              flex: 73,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 10,
                    ),
                    const Expanded(flex: 10, child: LoginTextTitle()),
                    Expanded(
                        flex: 15,
                        child: LoginTextFieldEmail(
                          formKey: loginPageEmailKey,
                        )),
                    Expanded(
                        flex: 15,
                        child: LoginTextFieldPassword(
                          formKey: loginPagePasswordKey,
                        )),
                    const Spacer(
                      flex: 5,
                    ),
                    const Expanded(flex: 10, child: BtnLogin()),
                    const Spacer(
                      flex: 3,
                    ),
                    const Expanded(
                        flex: 10, child: TextWidgetDontHaveAccount()),
                    const Spacer(
                      flex: 5,
                    ),
                    const Expanded(flex: 10, child: SocialMediaIcons()),
                    const Spacer(
                      flex: 7,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
