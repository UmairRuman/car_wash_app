import 'package:car_wash_app/Client/pages/indiviual_category_page/controller/favourite_icon_state_controller.dart';
import 'package:car_wash_app/Controllers/favourite_service__state_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRowIndiviualCategoryPage extends ConsumerWidget {
  final String serviceName;
  final String serviceId;

  final String serviceImageUrl;

  const TopRowIndiviualCategoryPage(
      {super.key,
      required this.serviceImageUrl,
      required this.serviceName,
      required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(favouriteIconStateProvider);
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_ios),
                ))),
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
                  onTap: () async {
                    largeTextInformerDialog(context, "Adding to Favourite");
                    await ref
                        .read(favouriteServiceProvider.notifier)
                        .addToFavourite(
                            serviceName, serviceImageUrl, serviceId);
                    await ref
                        .read(favouriteIconStateProvider.notifier)
                        .checkForFavouriteOrNot(serviceId);
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    size: 30,
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
                secondChild: InkWell(
                  onTap: () async {
                    largeTextInformerDialog(context, "UnFavouriting service");
                    await ref
                        .read(favouriteServiceProvider.notifier)
                        .deleteFavouriteService(serviceId.toString());
                    await ref
                        .read(favouriteIconStateProvider.notifier)
                        .checkForFavouriteOrNot(serviceId);
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    size: 30,
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                crossFadeState: state
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
