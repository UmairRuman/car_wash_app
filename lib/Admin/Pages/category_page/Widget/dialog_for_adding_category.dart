import 'dart:io';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ServiceCategoryVariables {
  static String? imageFilePath;
  static bool isClickedOnCamera = false;
}

void dialogForAddingServiceCategory(BuildContext context) {
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
                          flex: 50,
                          child: Builder(builder: (context) {
                            if (ServiceCategoryVariables.isClickedOnCamera &&
                                ServiceCategoryVariables.imageFilePath !=
                                    null) {
                              ref
                                  .read(serviceAddtionStateProvider.notifier)
                                  .isIconPicked = true;
                              ref
                                  .read(serviceAddtionStateProvider.notifier)
                                  .onChangeIconUrl(
                                      ServiceCategoryVariables.imageFilePath!);
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: FileImage(File(
                                          ServiceCategoryVariables
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
                                                ServiceCategoryVariables
                                                    .isClickedOnCamera = true;
                                              });

                                              var file = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);

                                              if (file == null) {
                                                setState(() {
                                                  ServiceCategoryVariables
                                                          .isClickedOnCamera =
                                                      false;
                                                });
                                              } else {
                                                setState(() {
                                                  ServiceCategoryVariables
                                                          .imageFilePath =
                                                      file.path;
                                                  ServiceCategoryVariables
                                                      .isClickedOnCamera = true;
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
                              flex: 6,
                            ),
                            Expanded(
                              flex: 40,
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    ServiceCategoryVariables.isClickedOnCamera =
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
                                  Navigator.of(context).pop();
                                  ref
                                      .read(
                                          serviceAddtionStateProvider.notifier)
                                      .onSaveBtnClick();
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
          ),
        );
      });
}
