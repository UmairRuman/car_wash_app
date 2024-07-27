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

                                                FirebaseStorage.instance
                                                    .ref()
                                                    .child("Images")
                                                    .child(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .child(
                                                        "PreviousServiceImages")
                                                    .child(ref
                                                        .read(
                                                            previousServiceStateProvider
                                                                .notifier)
                                                        .previousServiceNameTEC
                                                        .text)
                                                    .putFile(File(file.path))
                                                    .then((snapshot) async {
                                                  var imagePath = await snapshot
                                                      .ref
                                                      .getDownloadURL();
                                                  ref
                                                      .read(
                                                          previousServiceStateProvider
                                                              .notifier)
                                                      .setNewPreviousImage(
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
                            flex: 6,
                          ),
                          Expanded(
                            flex: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  AddingPreviousDataVariables
                                      .isClickedOnCamera = false;
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
                                ref
                                    .read(previousServiceStateProvider.notifier)
                                    .insertPreviousData();
                                Navigator.of(context).pop();
                                setState(() {
                                  AddingPreviousDataVariables
                                      .isClickedOnCamera = false;
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
