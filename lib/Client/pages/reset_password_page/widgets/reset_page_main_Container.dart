import 'package:car_wash_app/Client/pages/reset_password_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/reset_password_page/widgets/icons.dart';
import 'package:car_wash_app/Client/pages/reset_password_page/widgets/texts.dart';
import 'package:flutter/material.dart';

class ResetPageMainContainer extends StatelessWidget {
  const ResetPageMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(
          flex: 15,
        ),
        Expanded(flex: 10, child: PasswordIcon()),
        Spacer(
          flex: 5,
        ),
        Expanded(flex: 10, child: TextResetYourPassword()),
        Expanded(flex: 5, child: TextEnterYourGmail()),
        Expanded(flex: 20, child: GmailForResetingPassword()),
        Expanded(flex: 10, child: BtnResetPassword()),
        Spacer(
          flex: 15,
        ),
      ],
    );
  }
}
