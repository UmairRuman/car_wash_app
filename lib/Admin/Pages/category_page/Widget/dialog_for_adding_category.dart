import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ServiceIconCategoryVariables {
  static String? imageFilePath;
  static bool isClickedOnCamera = false;
  static bool isIconModified = false;
}

void dialogForAddingServiceCategory(BuildContext context, WidgetRef ref) {
  showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) => Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 50,
                        child: Builder(builder: (context) {
                          if (ServiceIconCategoryVariables.isClickedOnCamera &&
                              ServiceIconCategoryVariables.imageFilePath !=
                                  null) {
                            ref
                                .read(serviceAddtionStateProvider.notifier)
                                .isIconPicked = true;

                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(File(
                                        ServiceIconCategoryVariables
                                            .imageFilePath!)),
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
                                              ServiceIconCategoryVariables
                                                  .isClickedOnCamera = true;
                                            });

                                            var file = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);

                                            if (file == null) {
                                              setState(() {
                                                ServiceIconCategoryVariables
                                                    .isClickedOnCamera = false;
                                              });
                                            } else {
                                              setState(() {
                                                ServiceIconCategoryVariables
                                                    .imageFilePath = file.path;
                                                ServiceIconCategoryVariables
                                                    .isClickedOnCamera = true;
                                                ServiceIconCategoryVariables
                                                    .isIconModified = true;
                                              });
                                            }
                                          },
                                          child: Image.asset(cameraImage))),
                                  const Expanded(
                                      flex: 20,
                                      child: Text("Click To service Icon")),
                                  const Spacer(
                                    flex: 20,
                                  )
                                ],
                              ),
                            ],
                          );
                        })),
                    const Spacer(
                      flex: 5,
                    ),
                    Expanded(
                      flex: 30,
                      child: TextField(
                        controller: ref
                            .read(serviceAddtionStateProvider.notifier)
                            .serviecNameTEC,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            hintText: 'Service Name'),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Row(
                        children: [
                          const Spacer(
                            flex: 10,
                          ),
                          Expanded(
                            flex: 35,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  ServiceIconCategoryVariables.imageFilePath =
                                      null;
                                  ServiceIconCategoryVariables
                                      .isClickedOnCamera = false;
                                });
                              },
                              color: Colors.blue,
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 10,
                          ),
                          Expanded(
                            flex: 35,
                            child: MaterialButton(
                              onPressed: () async {
                                dialogForAddingService(context);
                                //On save button click we have to upload image to the firebaseStorage box
                                log("File path ${ServiceIconCategoryVariables.imageFilePath}");
                                if (ServiceIconCategoryVariables
                                        .imageFilePath !=
                                    null) {
                                  await storingServiceIconAtFireStore(
                                      ref,
                                      ServiceIconCategoryVariables
                                          .imageFilePath!);

                                  ServiceIconCategoryVariables.imageFilePath =
                                      null;
                                  ServiceIconCategoryVariables
                                      .isClickedOnCamera = false;

                                  await ref
                                      .read(
                                          serviceAddtionStateProvider.notifier)
                                      .onSaveBtnClick();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                              color: Colors.blue,
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 10,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<void> storingServiceIconAtFireStore(WidgetRef ref, String file) async {
  String serviceName =
      ref.read(serviceAddtionStateProvider.notifier).serviecNameTEC.text;
  final path =
      "Images/${FirebaseAuth.instance.currentUser!.uid}/ServiceAssets/$serviceName/icon";
  final snapshot =
      await FirebaseStorage.instance.ref().child(path).putFile(File(file));
  log("Uploaded path: $path");

  var imagePath = await snapshot.ref.getDownloadURL();
  log("Downloaded path $imagePath");
  ref.read(serviceAddtionStateProvider.notifier).onChangeIconUrl(imagePath);
}

void dialogForAddingService(BuildContext context) {
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
                "Adding service...",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          )),
        ),
      );
    },
  );
}
