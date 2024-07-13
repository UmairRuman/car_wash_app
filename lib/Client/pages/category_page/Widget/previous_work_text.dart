import 'package:car_wash_app/Admin/Pages/category_page/Widget/dialog.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePagePreviousServiceText extends ConsumerWidget {
  const HomePagePreviousServiceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        const Expanded(
            flex: 25,
            child: FittedBox(
              child: Text(
                stringPreviousWork,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )),
        const Spacer(
          flex: 50,
        ),
        Expanded(
            flex: 15,
            child: InkWell(
              onTap: () {
                dialogForAddingPreviousData(context);
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 201, 218, 232),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(Icons.add)),
            )),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
