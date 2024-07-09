import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_year_dialog.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/controller/date_time_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextSelectDate extends StatelessWidget {
  const TextSelectDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        const Expanded(
          flex: 25,
          child: FittedBox(
            child: Text(
              "Select Year",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(flex: 10, child: Icon(Icons.arrow_forward)),
        const Spacer(
          flex: 40,
        ),
        Expanded(
            flex: 15,
            child: InkWell(
              onTap: () {
                dialogForEditYear(context);
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 201, 218, 232),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(Icons.date_range_rounded)),
            )),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}

class SelectedDate extends ConsumerWidget {
  const SelectedDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentDate = ref.watch(dateProvider);
    return FittedBox(
        child: Text(
      "${currentDate.year}-${currentDate.month}-${currentDate.day}",
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Color.fromARGB(255, 24, 97, 156)),
    ));
  }
}
