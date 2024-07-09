import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_car_model_info.dart';
import 'package:flutter/material.dart';

class TextChooseYourCarModel extends StatelessWidget {
  const TextChooseYourCarModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        const Expanded(
          flex: 40,
          child: FittedBox(
            child: Text(
              "Add new Car model",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(flex: 10, child: Icon(Icons.arrow_forward)),
        const Spacer(
          flex: 25,
        ),
        Expanded(
            flex: 15,
            child: InkWell(
              onTap: () {
                dialogForEditCarInfo(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 201, 218, 232),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Icon(Icons.add)),
              ),
            )),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
