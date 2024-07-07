import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class ButtonBookAWash extends StatelessWidget {
  const ButtonBookAWash({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 80,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            child: const Text(
              stringBookAWash,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}
