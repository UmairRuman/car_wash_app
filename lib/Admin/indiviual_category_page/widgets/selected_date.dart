import 'package:car_wash_app/Client/pages/indiviual_category_page/controller/date_time_controller.dart';
import 'package:car_wash_app/utils/strings.dart';
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
        Expanded(
          flex: 25,
          child: FittedBox(
            child: Text(
              stringSelectDate,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Spacer(
          flex: 45,
        ),
        const Expanded(flex: 20, child: SelectedDate()),
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
