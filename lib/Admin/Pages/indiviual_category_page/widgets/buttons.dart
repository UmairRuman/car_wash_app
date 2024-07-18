import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonSaveService extends ConsumerWidget {
  final int serviceId;
  final String serviceName;
  final String imagePath;
  const ButtonSaveService(
      {super.key,
      required this.serviceId,
      required this.serviceName,
      required this.imagePath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 80,
          child: FloatingActionButton(
            onPressed: () {
              ref
                  .read(allServiceDataStateProvider.notifier)
                  .updateService(serviceId, serviceName);
            },
            backgroundColor: Colors.blue,
            child: const Text(
              "Save Service",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        const Spacer(
          flex: 10,
        ),
      ],
    );
  }
}
