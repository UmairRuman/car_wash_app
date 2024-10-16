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
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                const TextSpan(
                    text:
                        "To create your account please verify your email. We have send you email on "),
                TextSpan(
                    text: email,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 53, 143, 217),
                        fontWeight: FontWeight.bold)),
                const TextSpan(text: " .Kindly check your email."),
              ]),
          textAlign: TextAlign.center,
        ));
  }
}
