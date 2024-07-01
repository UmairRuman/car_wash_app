import 'package:car_wash_app/pages/login_page/controller/sign_in_controller.dart';
import 'package:car_wash_app/utils/validations/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginTextFieldEmail extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const LoginTextFieldEmail({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 80,
          child: Form(
            key: formKey,
            child: StatefulBuilder(
              builder: (context, setState) => TextFormField(
                  validator: emailValidator,
                  onChanged: (value) {
                    setState(() {
                      formKey.currentState!.validate();
                    });
                  },
                  controller:
                      ref.read(signInInfoProvider.notifier).emailSignInTEC,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      labelText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      ))),
            ),
          ),
        ),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}

class LoginTextFieldPassword extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const LoginTextFieldPassword({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 80,
          child: Form(
            key: formKey,
            child: StatefulBuilder(
              builder: (context, setState) => TextFormField(
                  onChanged: (value) {
                    setState(() {
                      formKey.currentState!.validate();
                    });
                  },
                  validator: passwordValidator,
                  controller:
                      ref.read(signInInfoProvider.notifier).passwordSignInTEC,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      labelText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ))),
            ),
          ),
        ),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}
