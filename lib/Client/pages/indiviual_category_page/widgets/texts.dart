import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_car_model_info.dart';
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
              "Choose your Car type",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Spacer(
          flex: 35,
        ),
        Expanded(
            flex: 15,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8),
              child: Icon(Icons.arrow_forward),
            )),
        Spacer(
          flex: 5,
        )
      ],
    );
  }
}

class TextChooseTimeSlot extends StatelessWidget {
  const TextChooseTimeSlot({super.key});

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
              "Choose Time Slot",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Spacer(
          flex: 35,
        ),
        Expanded(
            flex: 15,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8),
              child: Icon(Icons.arrow_forward),
            )),
        Spacer(
          flex: 5,
        )
      ],
    );
  }
}
