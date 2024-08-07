import 'package:car_wash_app/Client/pages/reset_password_page/model/text_controller.dart';
import 'package:car_wash_app/utils/validations/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextResetYourPassword extends StatelessWidget {
  const TextResetYourPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
        child: Text(
      "Reset your password!",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ));
  }
}

class GmailForResetingPassword extends ConsumerStatefulWidget {
  const GmailForResetingPassword({super.key});

  @override
  ConsumerState<GmailForResetingPassword> createState() =>
      _GmailForResetingPasswordState();
}

class _GmailForResetingPasswordState
    extends ConsumerState<GmailForResetingPassword> {
  final emailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 5),
        Expanded(
          flex: 90,
          child: Form(
            key: emailFormKey,
            child: StatefulBuilder(
              builder: (context, setState) => TextFormField(
                onChanged: (value) {
                  setState(() {
                    ref.read(emailTextProvider.notifier).onChangeEmailText();
                    emailFormKey.currentState!.validate();
                  });
                },
                validator: emailValidator,
                controller: ref.read(emailTextProvider.notifier).emailTEc,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 5),
      ],
    );
  }
}

class TextEnterYourGmail extends StatelessWidget {
  const TextEnterYourGmail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Enter your email to reset your password!",
      textAlign: TextAlign.center,
    );
  }
}
