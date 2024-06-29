import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class HomePagePreviousServiceText extends StatelessWidget {
  const HomePagePreviousServiceText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        FittedBox(
            child: Expanded(
                flex: 30,
                child: Text(
                  stringPreviousWork,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ))),
        const Spacer(
          flex: 65,
        ),
      ],
    );
  }
}
