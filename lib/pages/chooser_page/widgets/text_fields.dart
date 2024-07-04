import 'package:flutter/material.dart';

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

class ChooserPagePhoneNumber extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const ChooserPagePhoneNumber({super.key, required this.formKey});

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
                  // setState(() {
                  //   formKey.currentState!.validate();
                  // });
                },
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Phone Number",
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
