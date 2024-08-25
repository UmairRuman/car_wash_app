import 'dart:io';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_info_controlller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ServiceClassVariables {
  static String? imageFilePath;
  static String downladedImagePath = "";
  static bool isClickedOnCamera = false;
  static bool isImageModified = false;
}

void dialogForEdditingServiceImageAndDescription(
    BuildContext context,
    String serviceName,
    String serviceId,
    String imagePath,
    WidgetRef ref,
    bool isFavourite,
    String serviceDescription,
    TextEditingController descriptionTEC) {
  showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), // this right here
          child: StatefulBuilder(
            builder: (context, setState) {
              // We store the ref's notifier values locally to avoid using ref in async callbacks.

              return Container(
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
                                  const Spacer(flex: 20),
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
                                              });
                                            }
                                          },
                                          child: Image.asset(cameraImage))),
                                  const Expanded(
                                      flex: 20,
                                      child: Text("Click To pick image")),
                                  const Spacer(flex: 20),
                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                      Expanded(
                        flex: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLength: 100,
                            maxLines: 5,
                            controller: descriptionTEC,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Service Description'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: Row(
                          children: [
                            const Spacer(flex: 6),
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
                                backgroundColor: Colors.blue,
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer(flex: 8),
                            Expanded(
                              flex: 40,
                              child: FloatingActionButton(
                                onPressed: () async {
                                  informerDialog(context, "Updating Service");
                                  serviceDescription = ref
                                      .read(serviceInfoProvider.notifier)
                                      .serviceDescriptionTEC
                                      .text;

                                  await addServiceImageToFirebaseStorageBox(
                                      serviceName,
                                      ServiceClassVariables.imageFilePath!,
                                      context);

                                  // Update the service info.
                                  await ref
                                      .read(serviceInfoProvider.notifier)
                                      .updateServiceImageAndDescription(
                                          serviceName,
                                          serviceDescription,
                                          serviceId,
                                          prefs!.getString(
                                              SharedPreferncesConstants
                                                  .adminkey)!,
                                          ServiceClassVariables
                                              .downladedImagePath,
                                          context);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    ServiceClassVariables.isClickedOnCamera =
                                        false;
                                    ServiceClassVariables.imageFilePath = null;
                                  });
                                },
                                backgroundColor: Colors.blue,
                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer(flex: 6),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
}

Future<void> addServiceImageToFirebaseStorageBox(
    String serviceName, String filePath, BuildContext context) async {
  // Handle image upload outside the setState callback.

  var snapshot = await FirebaseStorage.instance
      .ref()
      .child("Images")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("ServiceAssets")
      .child(serviceName)
      .child("image")
      .putFile(File(filePath));

  var newImagePath = await snapshot.ref.getDownloadURL();

  // Only interact with ref if the widget is still mounted.
  if (context.mounted) {
    ServiceClassVariables.downladedImagePath = newImagePath;
  }
}
