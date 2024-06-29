import 'package:car_wash_app/pages/sign_up_page/controller/sign_up_page_controller.dart';
import 'package:car_wash_app/utils/validations/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldName extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const TextFieldName({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(flex: 10),
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
                validator: nameValidator,
                controller: ref.read(signUpPageProvider.notifier).nameTEC,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Icon(Icons.person_2, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 10),
      ],
    );
  }
}

class TextFieldEmail extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const TextFieldEmail({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(flex: 10),
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
                validator: emailValidator,
                controller: ref.read(signUpPageProvider.notifier).emailTEC,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 10),
      ],
    );
  }
}

class TextFieldPassword extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const TextFieldPassword({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(flex: 10),
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
                controller: ref.read(signUpPageProvider.notifier).passwordTEC,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 10),
      ],
    );
  }
}
