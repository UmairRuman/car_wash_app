import 'package:flutter/material.dart';

class TextVerifyYourEmail extends StatelessWidget {
  const TextVerifyYourEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
        child: Text(
      "Verify your email!",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ));
  }
}

class TextCheckYourEmail extends StatelessWidget {
  final String email;
  const TextCheckYourEmail({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Text(
      "We have send you email on $email , Kindly check your email!",
      textAlign: TextAlign.center,
    ));
  }
}
