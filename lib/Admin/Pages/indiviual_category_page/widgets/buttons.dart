import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  void dialogFordeletingService(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 100,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Center(
                child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Deleting service...",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              ],
            )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ServiceCollection serviceCollection = ServiceCollection();
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 201, 217, 230),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Row(children: [
        const Spacer(
          flex: 20,
        ),
        Expanded(
          flex: 80,
          child: FloatingActionButton(
            heroTag: "12",
            onPressed: () async {
              dialogFordeletingService(context);
              await ref
                  .read(serviceAddtionStateProvider.notifier)
                  .deleteSpecificService(serviceName, serviceId);
              Navigator.pop(context);
              Navigator.pop(context);
              final folderPath =
                  "Images/${FirebaseAuth.instance.currentUser!.uid}/ServiceAssets/$serviceName";

              log("Deleting folder path: $folderPath");

              try {
                // List all files within the folder
                final ListResult result =
                    await FirebaseStorage.instance.ref(folderPath).listAll();

                // Delete each file
                for (var ref in result.items) {
                  log("Deleting file: ${ref.fullPath}");
                  await ref.delete();
                }

                log("All files deleted successfully.");
                //After it we also have to delete it from firestore
              } catch (e) {
                log("Error deleting files: $e");
              }
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
      ]),
    );
  }
}
