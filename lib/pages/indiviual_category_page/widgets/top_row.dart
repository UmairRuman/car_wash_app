import 'package:flutter/material.dart';

class TopRowIndiviualCategoryPage extends StatelessWidget {
  const TopRowIndiviualCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 5,
        ),
        Expanded(flex: 10, child: Icon(Icons.arrow_back_ios)),
        Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 30,
            child: FittedBox(
                child: Text(
              "Car Wash",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 103, 167)),
            ))),
        Spacer(
          flex: 20,
        ),
        Expanded(flex: 10, child: Icon(Icons.favorite_outline)),
        Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
