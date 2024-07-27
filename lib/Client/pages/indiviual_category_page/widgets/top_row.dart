import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/Controllers/favourite_service__state_controller.dart';
import 'package:car_wash_app/Controllers/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRowIndiviualCategoryPage extends ConsumerWidget {
  final String serviceName;
  final String serviceId;
  bool isFavourite;
  final String serviceImageUrl;
  final String favouriteServiceId;
  TopRowIndiviualCategoryPage(
      {super.key,
      required this.serviceImageUrl,
      required this.serviceName,
      required this.isFavourite,
      required this.favouriteServiceId,
      required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 10,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back_ios))),
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 30,
            child: FittedBox(
                child: Text(
              serviceName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 103, 167)),
            ))),
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 10,
            child: StatefulBuilder(
              builder: (context, setState) => AnimatedCrossFade(
                firstChild: InkWell(
                  onTap: () {
                    setState(() {
                      isFavourite = true;
                      ref
                          .read(favouriteServiceProvider.notifier)
                          .addToFavourite(serviceName, serviceImageUrl,
                              serviceId.toString());
                      ref
                          .read(allServiceDataStateProvider.notifier)
                          .updateService(serviceId, serviceName, isFavourite);
                    });
                  },
                  child: const Icon(
                    size: 30,
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
                secondChild: InkWell(
                  onTap: () {
                    setState(() {
                      isFavourite = false;
                      ref
                          .read(favouriteServiceProvider.notifier)
                          .deleteFavouriteService(serviceId.toString());
                      ref
                          .read(allServiceDataStateProvider.notifier)
                          .updateService(serviceId, serviceName, isFavourite);
                    });
                  },
                  child: const Icon(
                    size: 30,
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
          flex: 5,
        )
      ],
    );
  }
}
