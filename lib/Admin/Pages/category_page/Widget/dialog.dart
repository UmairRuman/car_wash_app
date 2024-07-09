import 'dart:io';

import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? imageFilePath;
bool isClickedOnCamera = false;
void myDialog(BuildContext context) {
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
                          if (isClickedOnCamera && imageFilePath != null) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(File(imageFilePath!)),
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
                                              isClickedOnCamera = true;
                                            });

                                            var file = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);

                                            if (file == null) {
                                              setState(() {
                                                isClickedOnCamera = false;
                                              });
                                            } else {
                                              setState(() {
                                                imageFilePath = file.path;
                                                isClickedOnCamera = true;
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
                    const Expanded(
                      flex: 30,
                      child: TextField(
                        decoration: InputDecoration(
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
                                  isClickedOnCamera = false;
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
                              onPressed: () {},
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
