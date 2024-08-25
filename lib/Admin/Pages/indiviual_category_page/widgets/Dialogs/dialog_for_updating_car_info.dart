import 'dart:io';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/controller_for_updating_car_info.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/service_collection.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class CarInfoUpdatingModel {
  static bool isImageUpdated = false;
  static String imagePath = "";
  static String downloadedImagePath = "";
  static bool isNewImagePicked = false;
  static String carOldName = "";
}

void dialogForUpdatingCarInfo(
    BuildContext context,
    String carName,
    String serviceId,
    String carImagePath,
    String carWashPrice,
    bool isCarAssetImage,
    String serviceName,
    WidgetRef ref,
    TextEditingController carNameTEC) {
  ServiceCollection serviceCollection = ServiceCollection();
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  CarInfoUpdatingModel.carOldName = carName;
  int currentlySelectedPrice =
      int.parse(carWashPrice.substring(0, carWashPrice.length - 1));
  ref.read(carInfoUpdationProvider.notifier).onChangeCarName(carName);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: screenHeight / 2,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 30,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: CarInfoUpdatingModel.isNewImagePicked
                                  ? FileImage(
                                      File(CarInfoUpdatingModel.imagePath))
                                  : (isCarAssetImage
                                          ? AssetImage(carImagePath)
                                          : NetworkImage(carImagePath))
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: InkWell(
                            onTap: () async {
                              var file = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              if (file == null) {
                                setState(() {
                                  CarInfoUpdatingModel.isImageUpdated = false;
                                });
                              } else {
                                setState(() {
                                  CarInfoUpdatingModel.isImageUpdated = true;
                                  CarInfoUpdatingModel.isNewImagePicked = true;
                                  CarInfoUpdatingModel.imagePath = file.path;
                                });
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(flex: 5),
                  Expanded(
                    flex: 15,
                    child: TextField(
                      controller: carNameTEC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        hintText: 'Car Name',
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 40,
                    child: StatefulBuilder(
                      builder: (context, setState) => Row(
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
                                  value: currentlySelectedPrice,
                                  minValue: 1,
                                  maxValue: 10000,
                                  onChanged: (value) => setState(() {
                                    currentlySelectedPrice = value;
                                  }),
                                ),
                              ),
                              Expanded(
                                  flex: 20,
                                  child: FittedBox(
                                      child: Text(
                                          'Price: $currentlySelectedPrice\$'))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 15,
                    child: Row(
                      children: [
                        const Spacer(flex: 6),
                        Expanded(
                          flex: 40,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              carNameTEC.text = "";
                            },
                            backgroundColor: const Color(0xFF1BC0C5),
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
                              final adminId =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await uploadCarImageOnFirebaseStorageBox(
                                  serviceName);
                              await serviceCollection.updateCarInfo(
                                  adminId,
                                  serviceId,
                                  CarInfoUpdatingModel.carOldName,
                                  serviceName,
                                  "$currentlySelectedPrice\$",
                                  carNameTEC.text,
                                  CarInfoUpdatingModel.downloadedImagePath,
                                  false);

                              await ref
                                  .read(allServiceDataStateProvider.notifier)
                                  .fetchServiceData(serviceName, serviceId);

                              Navigator.of(context).pop();
                            },
                            backgroundColor: const Color(0xFF1BC0C5),
                            child: const Text(
                              "Update",
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
            );
          },
        ),
      );
    },
  );
}

Future<void> uploadCarImageOnFirebaseStorageBox(String serviceName) async {
  // Upload the image to Firebase Storage
  var snapshot = await FirebaseStorage.instance
      .ref()
      .child("Images")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("ServiceAssets")
      .child(serviceName)
      .child("carImages")
      .child(CarInfoUpdatingModel.carOldName)
      .putFile(File(CarInfoUpdatingModel.imagePath));

  // Get the download URL
  CarInfoUpdatingModel.downloadedImagePath =
      await snapshot.ref.getDownloadURL();
}
