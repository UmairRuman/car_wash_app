import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Client/pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/view/indiviual_category_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/Controllers/favourite_service__state_controller.dart';
import 'package:car_wash_app/Controllers/rating_controller.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteCategoryBookButton extends ConsumerWidget {
  final String serviceName;
  final String serviceId;
  final String serviceImage;

  const FavouriteCategoryBookButton(
      {super.key,
      required this.serviceId,
      required this.serviceName,
      required this.serviceImage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFavourite = true;
    return Column(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 20,
            child: StatefulBuilder(
              builder: (context, setState) => AnimatedCrossFade(
                firstChild: InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
                secondChild: InkWell(
                  onTap: () async {
                    setState(() {
                      isFavourite = false;
                    });
                    await Future.delayed(const Duration(seconds: 1));
                    ref
                        .read(favouriteServiceProvider.notifier)
                        .deleteFavouriteService(serviceId.toString());
                    ref
                        .read(allServiceDataStateProvider.notifier)
                        .updateService(serviceId, serviceName, isFavourite);
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                crossFadeState: isFavourite
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            )),
        const Spacer(
          flex: 50,
        ),
        Expanded(
          flex: 25,
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) => InkWell(
                onTap: () {
                  ref
                      .read(ratingStateProvider.notifier)
                      .getSpecificUserRating(serviceId, serviceName);
                  ref
                      .read(allServiceDataStateProvider.notifier)
                      .fetchServiceData(serviceName, serviceId);
                  ref.read(timeSlotsStateProvider.notifier).getTimeSlots(
                        DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day),
                      );
                  Navigator.of(context).pushNamed(
                      IndiviualCategoryPage.pageName,
                      arguments: ImageAndServiceNameSender(
                          serviceID: serviceId,
                          categoryName: serviceName,
                          imagePath: serviceImage));
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
                      stringBookButton,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
