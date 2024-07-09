import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class TextChooseYourCarModel extends StatelessWidget {
  const TextChooseYourCarModel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 5,
        ),
        Expanded(
          flex: 40,
          child: FittedBox(
            child: Text(
              stringChooseYourCarModel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Spacer(
          flex: 35,
        ),
        Expanded(flex: 15, child: Icon(Icons.arrow_forward)),
        Spacer(
          flex: 5,
        )
      ],
    );
  }
}

class CategoryTextDescription extends StatelessWidget {
  const CategoryTextDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(),
      cursorColor: Colors.red,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        hintText: 'Title',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
