import 'package:flutter/material.dart';

class TopRowIndiviualCategoryPage extends StatelessWidget {
  final String serviceName;
  const TopRowIndiviualCategoryPage({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 10,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back_ios))),
        const Spacer(
          flex: 20,
        ),
        const Expanded(
            flex: 30,
            child: FittedBox(
                child: Text(
              "Car Wash",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 103, 167)),
            ))),
        const Spacer(
          flex: 20,
        ),
        const Expanded(flex: 10, child: Icon(Icons.favorite_outline)),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
