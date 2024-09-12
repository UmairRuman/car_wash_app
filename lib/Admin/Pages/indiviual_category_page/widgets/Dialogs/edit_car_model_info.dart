import 'dart:developer';
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
  static String downloadedImagePath = "";
}

void dialogForEditCarInfo(
    BuildContext context, String serviceName, String serviceId, WidgetRef ref) {
  String newImagePath = "";
  showDialog(
      barrierDismissible: false,
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
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      // CarInfoVariables.imageFilePath = null;
                                      CarInfoVariables.isClickedOnCamera =
                                          false;
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
                                flex: 8,
                              ),
                              Expanded(
                                flex: 40,
                                child: MaterialButton(
                                  onPressed: () async {
                                    // Show loading dialog
                                    if (ref
                                                .read(carInfoProvider.notifier)
                                                .carNameTEC
                                                .text !=
                                            "" &&
                                        CarInfoVariables.imageFilePath !=
                                            null) {
                                      dialogForLoadingCarImage(context);

                                      try {
                                        // Store car image in Firebase Storage

                                        await storingServiceCarImagesAtFireStore(
                                            ref,
                                            CarInfoVariables.imageFilePath!,
                                            serviceName);
                                        log("In save button ${CarInfoVariables.downloadedImagePath}");
                                        // Update the car info with the new image path
                                        ref
                                            .read(carInfoProvider.notifier)
                                            .onChangeCarPic(CarInfoVariables
                                                .downloadedImagePath);

                                        ref
                                                .read(
                                                    allServiceDataStateProvider
                                                        .notifier)
                                                .carImageUrl =
                                            CarInfoVariables
                                                .downloadedImagePath;
                                        // Reset variables
                                        CarInfoVariables.isClickedOnCamera =
                                            false;
                                        CarInfoVariables.imageFilePath = null;

                                        // Call save button logic
                                        ref
                                            .read(carInfoProvider.notifier)
                                            .onSaveButtonClick();
                                        await ref
                                            .read(allServiceDataStateProvider
                                                .notifier)
                                            .addCars(serviceId, serviceName);
                                      } finally {
                                        // Ensure dialog is closed even if an error occurs
                                        if (context.mounted) {
                                          Navigator.of(context)
                                              .pop(); // Close loading dialog
                                          Navigator.of(context)
                                              .pop(); // Close the edit dialog
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "No Field can't be null!")));
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

Future<void> storingServiceCarImagesAtFireStore(
    WidgetRef ref, String file, String serviceName) async {
  var snapshot = await FirebaseStorage.instance
      .ref()
      .child("Images")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("ServiceAssets")
      .child(serviceName)
      .child("carImages")
      .child(ref.read(carInfoProvider.notifier).carNameTEC.text)
      .putFile(File(file));

  var imagePath = await snapshot.ref.getDownloadURL();
  CarInfoVariables.downloadedImagePath = imagePath;
}

void dialogForLoadingCarImage(BuildContext context) {
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
                "Adding Car data...",
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
