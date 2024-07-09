import 'dart:io';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/car_info_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class CarInfoVariables {
  static String? imageFilePath;
  static int maxValue = 1000;
  static bool isClickedOnCamera = false;
}

void dialogForEditCarInfo(BuildContext context) {
  showDialog(
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
                child: Consumer(
                  builder: (context, ref, child) {
                    var carIntitalPrice =
                        ref.read(carInfoProvider.notifier).carIntialPrice;
                    var carCurrentPrice =
                        ref.read(carInfoProvider.notifier).carCurrentPrice;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 40,
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
                          flex: 25,
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
                            flex: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 70,
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
                                        flex: 30,
                                        child: FittedBox(
                                            child: Text(
                                                'Price: $carCurrentPrice\$'))),
                                  ],
                                ),
                              ],
                            )),
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
                                    ref
                                        .read(carInfoProvider.notifier)
                                        .onSaveButtonClick();
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
                    );
                  },
                ),
              ),
            ),
          ),
        );
      });
}
