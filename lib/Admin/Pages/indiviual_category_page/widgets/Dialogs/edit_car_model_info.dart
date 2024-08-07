import 'dart:io';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/car_info_controller.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class CarInfoVariables {
  static String? imageFilePath;
  static int maxValue = 1000;
  static bool isClickedOnCamera = false;
}

void dialogForEditCarInfo(BuildContext context, String serviceName,
    String serviceId, WidgetRef ref, bool isFavourite) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) {
              var carIntitalPrice =
                  ref.read(carInfoProvider.notifier).carIntialPrice;
              var carCurrentPrice =
                  ref.read(carInfoProvider.notifier).carCurrentPrice;
              return Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 30,
                            child: Builder(builder: (context) {
                              if (CarInfoVariables.isClickedOnCamera &&
                                  CarInfoVariables.imageFilePath != null) {
                                ref.read(carInfoProvider.notifier).isPickImage =
                                    true;

                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: FileImage(File(
                                            CarInfoVariables.imageFilePath!)),
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
                                                  CarInfoVariables
                                                      .isClickedOnCamera = true;
                                                });

                                                var file = await ImagePicker()
                                                    .pickImage(
                                                        source: ImageSource
                                                            .gallery);

                                                if (file == null) {
                                                  setState(() {
                                                    CarInfoVariables
                                                            .isClickedOnCamera =
                                                        false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    CarInfoVariables
                                                            .imageFilePath =
                                                        file.path;
                                                    CarInfoVariables
                                                            .isClickedOnCamera =
                                                        true;

                                                    FirebaseStorage.instance
                                                        .ref()
                                                        .child("Images")
                                                        .child(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .child("serviceImages")
                                                        .child(serviceName)
                                                        .child("carImages")
                                                        .child(ref
                                                            .read(
                                                                carInfoProvider
                                                                    .notifier)
                                                            .carNameTEC
                                                            .text)
                                                        .putFile(
                                                            File(file.path))
                                                        .then((snapshot) async {
                                                      var imagePath =
                                                          await snapshot.ref
                                                              .getDownloadURL();

                                                      ref
                                                          .read(carInfoProvider
                                                              .notifier)
                                                          .onChangeCarPic(
                                                              imagePath);
                                                    });
                                                  });
                                                }
                                              },
                                              child: Image.asset(cameraImage))),
                                      const Expanded(
                                          flex: 20,
                                          child:
                                              Text("Click To pick Car image")),
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
                                ref.read(carInfoProvider.notifier).carNameTEC,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: 'Car Name'),
                          ),
                        ),
                        Expanded(
                            flex: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 75,
                                      child: NumberPicker(
                                        selectedTextStyle: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        value: carCurrentPrice,
                                        minValue: carIntitalPrice,
                                        maxValue: CarInfoVariables.maxValue,
                                        onChanged: (value) => setState(() {
                                          ref
                                              .read(carInfoProvider.notifier)
                                              .isChangeCarPrice = true;
                                          ref
                                              .read(carInfoProvider.notifier)
                                              .onChangeCarPrice(value);
                                        }),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 20,
                                        child: FittedBox(
                                            child: Text(
                                                'Price: $carCurrentPrice\$'))),
                                  ],
                                ),
                              ],
                            )),
                        Expanded(
                          flex: 15,
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
                                      // CarInfoVariables.imageFilePath = null;
                                      CarInfoVariables.isClickedOnCamera =
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
                                      CarInfoVariables.isClickedOnCamera =
                                          false;
                                      CarInfoVariables.imageFilePath = null;
                                    });

                                    ref
                                        .read(carInfoProvider.notifier)
                                        .onSaveButtonClick();
                                    ref
                                        .read(allServiceDataStateProvider
                                            .notifier)
                                        .updateService(serviceId, serviceName,
                                            isFavourite);

                                    //After performing operation set all values to intial

                                    Navigator.of(context).pop();
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
                    )),
              );
            },
          ),
        );
      });
}
