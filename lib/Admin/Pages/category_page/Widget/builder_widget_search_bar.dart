import 'package:car_wash_app/Admin/Pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/view/admin_side_indiviual_category_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/Controllers/rating_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuilderWidgetSearchBar extends ConsumerWidget {
  final Services service;
  const BuilderWidgetSearchBar({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: () {
          ref
              .read(ratingStateProvider.notifier)
              .getSpecificUserRating(service.serviceId, service.serviceName);
          ref
              .read(allServiceDataStateProvider.notifier)
              .fetchServiceData(service.serviceName, service.serviceId);
          ref.read(timeSlotsStateProvider.notifier).getTimeSlots(
                DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
              );
          Navigator.of(context).pushNamed(
              AdminSideIndiviualCategoryPage.pageName,
              arguments: AdminSideImageAndServiceNameSender(
                  serviceID: service.serviceId,
                  categoryName: service.serviceName,
                  imagePath: service.imageUrl));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: service.isAssetIcon
                ? Image.asset(service.iconUrl)
                : Image.network(service.iconUrl),
            title: Text(service.serviceName),
          ),
        ),
      ),
    );
  }
}
