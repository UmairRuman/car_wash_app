import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/validations/validators.dart';
import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  const TextFieldName({super.key});

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
            key: nameKey,
            child: TextFormField(
                validator: nameValidator,
                controller: TextEditingController(),
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Name",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person_2,
                      color: Colors.purple,
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

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({super.key});

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
            key: emailKey,
            child: TextFormField(
                validator: emailValidator,
                controller: TextEditingController(),
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.purple,
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

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({super.key});

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
            key: passwordKey,
            child: TextFormField(
                validator: passwordValidator,
                controller: TextEditingController(),
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.purple,
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
