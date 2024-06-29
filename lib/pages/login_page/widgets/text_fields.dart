import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/validations/validators.dart';
import 'package:flutter/material.dart';

class LoginTextFieldEmail extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginTextFieldEmail({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 80,
          child: Form(
            key: formKey,
            child: TextFormField(
                validator: emailValidator,
                controller: TextEditingController(),
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
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}

class LoginTextFieldPassword extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginTextFieldPassword({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 80,
          child: Form(
            key: formKey,
            child: TextFormField(
                validator: passwordValidator,
                controller: TextEditingController(),
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
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}
