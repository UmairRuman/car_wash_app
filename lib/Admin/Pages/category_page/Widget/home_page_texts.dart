import 'package:car_wash_app/Admin/Pages/category_page/Widget/dialog_for_adding_category.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomePageServiceText extends ConsumerWidget {
  const AdminHomePageServiceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        const Expanded(
            flex: 30,
            child: FittedBox(
              child: Text(
                stringOurServices,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )),
        const Spacer(
          flex: 45,
        ),
        Expanded(
          flex: 15,
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: InkWell(
              onTap: () {
                dialogForAddingServiceCategory(context, ref);
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 201, 218, 232),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(Icons.add)),
            ),
          ),
        ),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
