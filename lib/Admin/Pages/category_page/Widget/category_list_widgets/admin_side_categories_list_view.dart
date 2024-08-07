import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/category_list_widgets/admin_side_state_widgets.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/view/admin_side_indiviual_category_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/Controllers/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdminSideCategoriesList extends ConsumerWidget {
  const AdminSideCategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(serviceAddtionStateProvider);
    var intialListOfService =
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
              return AdminSideServiceDataIntialStateWidget(
                listOfServices: intialListOfService,
              );
            } else if (state is ServiceDataLoadingState) {
              return const AdminSideServiceDataLoadingStateWidget();
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
                    return AnimationConfiguration.staggeredGrid(
                      duration: const Duration(milliseconds: 500),
                      position: index,
                      columnCount: 1,
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(ratingStateProvider.notifier)
                                  .getAllRatings(
                                      state.services[index].serviceId,
                                      state.services[index].serviceName);
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
                                  );
                              Navigator.of(context).pushNamed(
                                  AdminSideIndiviualCategoryPage.pageName,
                                  arguments: AdminSideImageAndServiceNameSender(
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
                                      : CachedNetworkImage(
                                          imageUrl:
                                              state.services[index].iconUrl,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Expanded(
                                  flex: 40,
                                  child: AutoSizeText(
                                    state.services[index].serviceName,
                                    style: const TextStyle(fontSize: 16),
                                    maxLines: 1,
                                    minFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
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
