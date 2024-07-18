import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/category_list_widgets/admin_side_state_widgets.dart';
import 'package:car_wash_app/Client/pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/state_widgets.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/view/indiviual_category_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesList extends ConsumerWidget {
  final List<Services> listOfServices;
  const CategoriesList({super.key, required this.listOfServices});

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
              return ServiceInitialState(listOfServices: listOfServices);
            } else if (state is ServiceDataLoadingState) {
              return const Scaffold(
                  body: Center(
                child: Row(
                  children: [
                    Text("Adding Services"),
                    CircularProgressIndicator(),
                  ],
                ),
              ));
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
                      Navigator.of(context).pushNamed(
                          IndiviualCategoryPage.pageName,
                          arguments: ImageAndServiceNameSender(
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
                            child: Image.file(
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
