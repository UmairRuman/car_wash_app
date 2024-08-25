import 'dart:io';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddingPreviousDataVariables {
  static String? imageFilePath;
  static bool isClickedOnCamera = false;
}

void dialogForAddingPreviousData(BuildContext context, WidgetRef ref) {
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
                          if (AddingPreviousDataVariables.isClickedOnCamera &&
                              AddingPreviousDataVariables.imageFilePath !=
                                  null) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(File(
                                        AddingPreviousDataVariables
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
                                            var file = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);

                                            if (file == null) {
                                              setState(() {
                                                AddingPreviousDataVariables
                                                    .isClickedOnCamera = false;
                                              });
                                            } else {
                                              setState(() {
                                                AddingPreviousDataVariables
                                                    .imageFilePath = file.path;
                                                AddingPreviousDataVariables
                                                    .isClickedOnCamera = true;
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
                    const Spacer(
                      flex: 5,
                    ),
                    Expanded(
                      flex: 30,
                      child: TextField(
                        controller: ref
                            .read(previousServiceStateProvider.notifier)
                            .previousServiceNameTEC,
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
                                  AddingPreviousDataVariables
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
                                dialogForAddingPreviousService(context);
                                var serviceName = ref
                                    .read(previousServiceStateProvider.notifier)
                                    .previousServiceNameTEC
                                    .text;
                                //We have also add previous images in firebase Storage box
                                if (AddingPreviousDataVariables.imageFilePath !=
                                    null) {
                                  await addPreviousImagesToFirebaseFirestore(
                                      serviceName,
                                      AddingPreviousDataVariables
                                          .imageFilePath!,
                                      ref);
                                }
                                ref
                                    .read(previousServiceStateProvider.notifier)
                                    .insertPreviousData();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                AddingPreviousDataVariables.isClickedOnCamera =
                                    false;
                              },
                              color: Colors.blue,
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

Future<void> addPreviousImagesToFirebaseFirestore(
    String serviceName, String file, WidgetRef ref) async {
  var snapshot = await FirebaseStorage.instance
      .ref()
      .child("Images")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("previousWorkImages")
      .child(serviceName)
      .putFile(File(file));

  var imagePath = await snapshot.ref.getDownloadURL();
  ref
      .read(previousServiceStateProvider.notifier)
      .setNewPreviousImage(imagePath);
}

void dialogForAddingPreviousService(BuildContext context) {
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
              Spacer(
                flex: 10,
              ),
              Expanded(flex: 20, child: CircularProgressIndicator()),
              Spacer(
                flex: 10,
              ),
              Expanded(
                flex: 50,
                child: FittedBox(
                  child: Text(
                    "Adding previous service...",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(flex: 10),
            ],
          )),
        ),
      );
    },
  );
}
