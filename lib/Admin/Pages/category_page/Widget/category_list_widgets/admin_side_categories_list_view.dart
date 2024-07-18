import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/category_list_widgets/admin_side_state_widgets.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/view/admin_side_indiviual_category_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideCategoriesList extends ConsumerWidget {
  final List<Services> listOfServices;
  const AdminSideCategoriesList({super.key, required this.listOfServices});

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
          child: Builder(builder: (context) {
            if (state is ServiceDataIntialState) {
              return AdminSideServiceDataIntialStateWidget(
                listOfServices: listOfServices,
              );
            } else if (state is ServiceDataLoadingState) {
              return const AdminSideServiceDataLoadingStateWidget();
            } else if (state is ServiceDataLoadedState) {
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      ref
                          .read(allServiceDataStateProvider.notifier)
                          .fetchServiceData(state.services[index].serviceName,
                              state.services[index].serviceId);
                      ref.read(timeSlotsStateProvider.notifier).getTimeSlots(
                          DateTime(DateTime.now().year, DateTime.now().month,
                              DateTime.now().day),
                          state.services[index].serviceId,
                          state.services[index].serviceName);
                      Navigator.of(context).pushNamed(
                          AdminSideIndiviualCategoryPage.pageName,
                          arguments: AdminSideImageAndServiceNameSender(
                              serviceID: state.services[index].serviceId,
                              categoryName: state.services[index].serviceName,
                              imagePath: state.services[index].iconUrl));
                      log("Clicked on $index");
                    },
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 5,
                        ),
                        Expanded(
                            flex: 40,
                            child: state.services[index].isAssetIcon
                                ? Image.asset(state.services[index].iconUrl)
                                : Image.file(
                                    File(state.services[index].iconUrl))),
                        Expanded(
                            flex: 40,
                            child: FittedBox(
                              child: Text(
                                state.services[index].serviceName,
                              ),
                            ))
                      ],
                    ),
                  );
                },
              );
            }
            return ServiceDataErrorStateWidget(
                error: (state as ServiceDataErrorState).error);
          }),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
