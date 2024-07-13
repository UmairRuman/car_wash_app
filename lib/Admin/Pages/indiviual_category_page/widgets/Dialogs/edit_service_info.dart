import 'dart:io';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_info_controlller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ServiceClassVariables {
  static String? imageFilePath;
  static bool isClickedOnCamera = false;
}

void dialogForEdditingServiceImageAndDescription(BuildContext context) {
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
                child: Consumer(
                  builder: (context, ref, child) => Column(
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
                                          ServiceClassVariables
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
                                                          .isClickedOnCamera =
                                                      false;
                                                });
                                              } else {
                                                setState(() {
                                                  ServiceClassVariables
                                                          .imageFilePath =
                                                      file.path;
                                                  ServiceClassVariables
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
                      Expanded(
                        flex: 15,
                        child: TextField(
                          controller:
                              ref.read(serviceInfoProvider.notifier).phoneNoTEC,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              hintText: 'Phone no'),
                        ),
                      ),
                      Expanded(
                        flex: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
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
                                  setState(() {
                                    ServiceClassVariables.isClickedOnCamera =
                                        false;
                                  });
                                  var serviceDescription = ref
                                      .read(serviceInfoProvider.notifier)
                                      .serviceDescriptionTEC
                                      .text;
                                  ref
                                      .read(serviceInfoProvider.notifier)
                                      .onChangeText(serviceDescription);
                                  if (ServiceClassVariables.imageFilePath !=
                                      null) {
                                    ref
                                        .read(serviceInfoProvider.notifier)
                                        .onChangeImagePath(ServiceClassVariables
                                            .imageFilePath!);
                                  }
                                  Navigator.of(context).pop();
                                  setState(() {
                                    ServiceClassVariables.isClickedOnCamera =
                                        false;
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
          ),
        );
      });
}
