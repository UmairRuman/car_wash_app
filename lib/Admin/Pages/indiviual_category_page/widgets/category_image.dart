import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_info_controlller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_service_info.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndiviualCategoryImageAndDescription extends ConsumerWidget {
  final String imagePath;
  const IndiviualCategoryImageAndDescription(
      {super.key, required this.imagePath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var serviceDescription =
        ref.read(serviceInfoProvider.notifier).intialServiceDescription;
    var changedImagePath = ref.watch(serviceInfoProvider);
    log("Image path :  $changedImagePath");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(3, 3),
                  color: Color.fromARGB(255, 151, 188, 219),
                  blurRadius: 3)
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Expanded(
                flex: 30,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: changedImagePath == ""
                              ? AssetImage(emptyImage)
                              : FileImage(File(changedImagePath)),
                          fit: BoxFit.fill)),
                )),
            const Spacer(
              flex: 5,
            ),
            Expanded(flex: 45, child: Text(serviceDescription)),
            Expanded(
                flex: 20,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 75,
                    ),
                    Expanded(
                      flex: 25,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) => InkWell(
                            onTap: () {
                              dialogForEdditingServiceImageAndDescription(
                                  context);
                            },
                            child: Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: const FittedBox(
                                fit: BoxFit.none,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
