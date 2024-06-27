import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/gradients.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class BtnLogin extends StatefulWidget {
  const BtnLogin({super.key});

  @override
  State<BtnLogin> createState() => _BtnLoginState();
}

class _BtnLoginState extends State<BtnLogin> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 25,
        ),
        Expanded(
          flex: 50,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () => {
              setState(() {
                emailKey.currentState!.validate();
                passwordKey.currentState!.validate();
              })
            },
            backgroundColor:
                Colors.transparent, // Set FAB background color to transparent
            elevation: 0, // Remove FAB elevation
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  gradient: gradientForButton),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                stringLogin,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 25,
        ),
      ],
    );
  }
}
