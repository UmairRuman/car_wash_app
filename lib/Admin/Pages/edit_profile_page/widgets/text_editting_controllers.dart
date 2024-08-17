import 'package:car_wash_app/Admin/Pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminEditNameTEC extends ConsumerWidget {
  const AdminEditNameTEC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller:
            ref.read(adminSideEditProfileInfoProvider.notifier).editNameTEC,
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

class AdminEditLocationTEC extends ConsumerWidget {
  const AdminEditLocationTEC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller:
            ref.read(adminSideEditProfileInfoProvider.notifier).editLocationTEC,
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

class AdminEditPhoneNoTEC extends ConsumerWidget {
  const AdminEditPhoneNoTEC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller:
            ref.read(adminSideEditProfileInfoProvider.notifier).editPhoneNoTEC,
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

class AdminEditPasswordTEC extends ConsumerWidget {
  const AdminEditPasswordTEC({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        maxLength: 6,
        controller:
            ref.read(adminSideEditProfileInfoProvider.notifier).editPasswordTEC,
        decoration: const InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Colors.white, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }
}
