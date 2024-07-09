import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/car_info_controller.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarModelContainer extends ConsumerWidget {
  const CarModelContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var imagePath = ref.read(carInfoProvider.notifier).carImagePath;
    var carServicePrice = ref.read(carInfoProvider.notifier).carCurrentPrice;
    var carName = ref.read(carInfoProvider.notifier).carName;
    log("Car Image path $imagePath");
    log("Car Service Price $carServicePrice");
    log("Car name : $carName");
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOfCarImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth / 3,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 248, 248),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 143, 193, 234),
                        offset: Offset(3, 3),
                        blurRadius: 3)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 55, child: Image.asset(listOfCarImages[index])),
                  Expanded(
                      flex: 25,
                      child: Text(
                        listofCarName[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    flex: 15,
                    child: Text(
                      listOfCarWashPrices[index],
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
