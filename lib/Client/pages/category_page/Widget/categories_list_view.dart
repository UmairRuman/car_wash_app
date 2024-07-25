import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/category_list_widgets/admin_side_state_widgets.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Client/pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/state_widgets.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/view/indiviual_category_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(serviceAddtionStateProvider);
    var listOfIntialServices =
        ref.read(allServiceDataStateProvider.notifier).intialListOfService;
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
          flex: 80,
          child: Builder(builder: (context) {
            if (state is ServiceDataIntialState) {
              return ServiceInitialState(listOfServices: listOfIntialServices);
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
              return AnimationLimiter(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 16,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    log("Is asset Icon : ${state.services[index].isAssetIcon}");
                    return AnimationConfiguration.staggeredGrid(
                      duration: const Duration(seconds: 1),
                      position: index,
                      columnCount: 1,
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(allServiceDataStateProvider.notifier)
                                  .fetchServiceData(
                                      state.services[index].serviceName,
                                      state.services[index].serviceId);
                              ref
                                  .read(timeSlotsStateProvider.notifier)
                                  .getTimeSlots(
                                      DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      state.services[index].serviceId,
                                      state.services[index].serviceName);
                              Navigator.of(context).pushNamed(
                                  IndiviualCategoryPage.pageName,
                                  arguments: ImageAndServiceNameSender(
                                      serviceID:
                                          state.services[index].serviceId,
                                      categoryName:
                                          state.services[index].serviceName,
                                      imagePath:
                                          state.services[index].iconUrl));
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
                                        ? Image.asset(
                                            state.services[index].iconUrl)
                                        : Image.network(
                                            state.services[index].iconUrl)),
                                Expanded(
                                    flex: 40,
                                    child: FittedBox(
                                      child: Text(
                                        state.services[index].serviceName,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
