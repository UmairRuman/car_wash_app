import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideLowerContainer extends ConsumerWidget {
  final String serviceId;
  final String serviceName;
  final String imagePath;
  const AdminSideLowerContainer(
      {super.key,
      required this.serviceId,
      required this.serviceName,
      required this.imagePath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 201, 217, 230),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Row(
        children: [
          const Spacer(
            flex: 20,
          ),
          Expanded(
            flex: 80,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
                ref
                    .read(serviceAddtionStateProvider.notifier)
                    .deleteSpecificService(serviceName, serviceId);
              },
              backgroundColor: Colors.blue,
              child: const Text(
                "Delete Service",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const Spacer(
            flex: 20,
          ),
        ],
      ),
    );
  }
}
