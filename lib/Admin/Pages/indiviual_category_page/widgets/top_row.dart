import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_name_dialog.dart';
import 'package:flutter/material.dart';

class AdminSideTopRowIndiviualCategoryPage extends StatelessWidget {
  final String serviceName;
  const AdminSideTopRowIndiviualCategoryPage(
      {super.key, required this.serviceName});

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
        Expanded(
            flex: 30,
            child: FittedBox(
                child: Text(
              serviceName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 103, 167)),
            ))),
        const Spacer(
          flex: 15,
        ),
        Expanded(
            flex: 15,
            child: InkWell(
              onTap: () {
                dialogForRating(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 201, 218, 232),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    )),
              ),
            )),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
