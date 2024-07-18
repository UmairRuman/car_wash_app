import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRowIndiviualCategoryPage extends ConsumerWidget {
  final String serviceName;
  const TopRowIndiviualCategoryPage({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var serviceName = ref.watch(serviceNameProvider);
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
        const Expanded(flex: 15, child: Icon(Icons.favorite_border_rounded)),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
