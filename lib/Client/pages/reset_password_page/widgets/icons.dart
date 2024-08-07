import 'package:flutter/material.dart';

class PasswordIcon extends StatelessWidget {
  const PasswordIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.lock_outline_rounded,
      color: Colors.blue,
      size: 80,
    );
  }
}
