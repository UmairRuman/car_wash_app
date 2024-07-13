import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/view/admin_side_indiviual_category_page.dart';
import 'package:car_wash_app/Client/pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(serviceAddtionStateProvider);
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
          flex: 80,
          child: Builder(
            builder: (context) => GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listOfCategoryName.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 16,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        AdminSideIndiviualCategoryPage.pageName,
                        arguments: ImageAndServiceNameSender(
                            serviceID: 2,
                            categoryName: listOfCategoryName[index],
                            imagePath: listOfPreviousWorkImages[index]));
                    log("Clicked on $index");
                  },
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 5,
                      ),
                      Expanded(
                          flex: 40,
                          child: Image.asset(listOfCategoryIcons[index])),
                      Expanded(
                          flex: 40,
                          child: FittedBox(
                            child: Text(
                              listOfCategoryName[index],
                            ),
                          ))
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
