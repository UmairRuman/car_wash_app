import 'package:car_wash_app/utils/global_keys.dart';
import 'package:car_wash_app/utils/gradients.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class BtnCreateAccount extends StatefulWidget {
  const BtnCreateAccount({super.key});

  @override
  State<BtnCreateAccount> createState() => _BtnCreateAccountState();
}

class _BtnCreateAccountState extends State<BtnCreateAccount> {
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
                passwordKey.currentState!.validate();
                emailKey.currentState!.validate();
                nameKey.currentState!.validate();
              })
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  gradient: gradientForButton),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                stringCreateAccount,
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
