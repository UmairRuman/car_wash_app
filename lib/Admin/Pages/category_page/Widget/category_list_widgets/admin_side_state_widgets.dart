import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Admin/Pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/view/admin_side_indiviual_category_page.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideServiceDataIntialStateWidget extends ConsumerWidget {
  final List<Services> listOfServices;
  const AdminSideServiceDataIntialStateWidget(
      {super.key, required this.listOfServices});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listOfServices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
                AdminSideIndiviualCategoryPage.pageName,
                arguments: AdminSideImageAndServiceNameSender(
                    serviceID: listOfServices[index].serviceId,
                    categoryName: listOfServices[index].serviceName,
                    imagePath: listOfServices[index].imageUrl));
            log("Clicked on $index");
          },
          child: Column(
            children: [
              const Spacer(
                flex: 5,
              ),
              Expanded(
                  flex: 40,
                  child: listOfServices[index].isAssetIcon
                      ? Image.asset(listOfServices[index].iconUrl)
                      : Image.network(listOfServices[index].iconUrl)),
              Expanded(
                  flex: 40,
                  child: FittedBox(
                    child: Text(
                      listOfServices[index].serviceName,
                    ),
                  ))
            ],
          ),
        );
      },
    );
    ;
  }
}

class AdminSideServiceDataLoadingStateWidget extends StatelessWidget {
  const AdminSideServiceDataLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ServiceDataErrorStateWidget extends StatelessWidget {
  final String error;
  const ServiceDataErrorStateWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
