import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePagePreviousServiceText extends ConsumerWidget {
  const HomePagePreviousServiceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 35,
            child: FittedBox(
              child: Text(
                stringPreviousWork,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )),
        Spacer(
          flex: 40,
        ),
        Expanded(flex: 15, child: Icon(Icons.arrow_forward)),
        Spacer(
          flex: 5,
        )
      ],
    );
  }
}
