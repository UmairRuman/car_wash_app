import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSlot extends ConsumerWidget {
  const TimeSlot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
        builder: (context, constraints) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listOfTimeSlots.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: constraints.maxHeight / 2,
                    width: constraints.maxWidth / 4,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 201, 219, 234),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(15, 15))),
                    child: Text(
                      listOfTimeSlots[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ));
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
          flex: 22,
          child: FittedBox(
            child: Text(
              stringChooseTimeSlot,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Spacer(
          flex: 55,
        ),
        Expanded(flex: 15, child: Icon(Icons.arrow_forward)),
        Spacer(
          flex: 3,
        )
      ],
    );
  }
}
