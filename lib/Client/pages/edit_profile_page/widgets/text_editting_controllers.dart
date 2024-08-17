import 'package:car_wash_app/Admin/Pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditNameTEC extends ConsumerWidget {
  const EditNameTEC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: ref.read(editProfileInfoProvider.notifier).editNameTEC,
        decoration: const InputDecoration(
            labelText: "Your Name",
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Colors.white, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }
}

class EditLocationTEC extends ConsumerWidget {
  const EditLocationTEC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: ref.read(editProfileInfoProvider.notifier).editLocationTEC,
        decoration: const InputDecoration(
            labelText: "Location",
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Colors.white, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }
}

class EditPhoneNoTEC extends ConsumerWidget {
  const EditPhoneNoTEC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: ref.read(editProfileInfoProvider.notifier).editPhoneNoTEC,
        decoration: const InputDecoration(
            labelText: "PhoneNO",
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Colors.white, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }
}
