import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class HomePagePreviousServiceText extends StatelessWidget {
  const HomePagePreviousServiceText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 5,
        ),
        FittedBox(
            child: Expanded(
                flex: 25,
                child: Text(
                  stringPreviousWork,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ))),
        Spacer(
          flex: 50,
        ),
        Expanded(
            flex: 15,
            child: Icon(
              Icons.arrow_forward,
            )),
        Spacer(
          flex: 5,
        )
      ],
    );
  }
}
