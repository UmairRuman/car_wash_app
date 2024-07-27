import 'dart:io';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_info_controlller.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ServiceClassVariables {
  static String? imageFilePath;
  static bool isClickedOnCamera = false;
  static bool isImageModified = false;
}

void dialogForEdditingServiceImageAndDescription(
    BuildContext context,
    String serviceName,
    String serviceId,
    String imagePath,
    WidgetRef ref,
    bool isFavourite) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) => Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 35,
                        child: Builder(builder: (context) {
                          if (ServiceClassVariables.isClickedOnCamera &&
                              ServiceClassVariables.imageFilePath != null) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(File(
                                        ServiceClassVariables.imageFilePath!)),
                                  )),
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(
                                    flex: 20,
                                  ),
                                  Expanded(
                                      flex: 40,
                                      child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              ServiceClassVariables
                                                  .isClickedOnCamera = true;
                                            });

                                            var file = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);

                                            if (file == null) {
                                              setState(() {
                                                ServiceClassVariables
                                                    .isClickedOnCamera = false;
                                              });
                                            } else {
                                              setState(() {
                                                ServiceClassVariables
                                                    .isImageModified = true;
                                                ServiceClassVariables
                                                    .imageFilePath = file.path;
                                                ServiceClassVariables
                                                    .isClickedOnCamera = true;
                                                FirebaseStorage.instance
                                                    .ref()
                                                    .child("Images")
                                                    .child(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .child("serviceImages")
                                                    .child(serviceName)
                                                    .putFile(File(file.path))
                                                    .then((snapshot) async {
                                                  var imagePath = await snapshot
                                                      .ref
                                                      .getDownloadURL();
                                                  ref
                                                      .read(serviceInfoProvider
                                                          .notifier)
                                                      .onChangeImagePath(
                                                          imagePath);
                                                });
                                              });
                                            }
                                          },
                                          child: Image.asset(cameraImage))),
                                  const Expanded(
                                      flex: 20,
                                      child: Text("Click To pic image")),
                                  const Spacer(
                                    flex: 20,
                                  )
                                ],
                              ),
                            ],
                          );
                        })),
                    Expanded(
                      flex: 45,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLength: 100,
                          maxLines: 5,
                          controller: ref
                              .read(serviceInfoProvider.notifier)
                              .serviceDescriptionTEC,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Service Descrption'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Row(
                        children: [
                          const Spacer(
                            flex: 6,
                          ),
                          Expanded(
                            flex: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  ServiceClassVariables.imageFilePath = null;
                                  ServiceClassVariables.isClickedOnCamera =
                                      false;
                                });
                              },
                              backgroundColor: const Color(0xFF1BC0C5),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 8,
                          ),
                          Expanded(
                            flex: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                var serviceDescription = ref
                                    .read(serviceInfoProvider.notifier)
                                    .serviceDescriptionTEC
                                    .text;
                                ref
                                    .read(serviceInfoProvider.notifier)
                                    .onChangeText(serviceDescription);

                                ref
                                    .read(allServiceDataStateProvider.notifier)
                                    .updateService(
                                        serviceId, serviceName, isFavourite);

                                Navigator.of(context).pop();
                                setState(() {
                                  ServiceClassVariables.isClickedOnCamera =
                                      false;
                                  ServiceClassVariables.imageFilePath = null;
                                });
                              },
                              backgroundColor: const Color(0xFF1BC0C5),
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
