import 'package:flutter/material.dart';

class EmailIcon extends StatelessWidget {
  const EmailIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.email_outlined,
      color: Colors.blue,
      size: 80,
    );
  }
}
