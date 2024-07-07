import 'dart:developer';

import 'package:car_wash_app/Client/pages/chooser_page/controller/phone_authenticatio_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ChooserPageNameTextField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const ChooserPageNameTextField({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
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
                controller: TextEditingController(),
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

class ChooserPagePhoneNumber extends ConsumerWidget {
  const ChooserPagePhoneNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PhoneNumber intialPhoneNumber = PhoneNumber(isoCode: "PK");
    return Row(
      children: [
        const Spacer(flex: 5),
        Expanded(
            flex: 90,
            child: InternationalPhoneNumberInput(
              initialValue: intialPhoneNumber,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              hintText: "Phone No",
              textFieldController:
                  ref.read(phoneNumberStateProvider.notifier).phoneNumberTEC,
              onInputChanged: (value) {
                ref.read(phoneNumberStateProvider.notifier).dialCode =
                    value.dialCode;
                log("${value.phoneNumber}");
                ref
                    .read(phoneNumberStateProvider.notifier)
                    .onChangePhoneNo(value.phoneNumber!);
              },
            )),
        const Spacer(flex: 5),
      ],
    );
  }
}
