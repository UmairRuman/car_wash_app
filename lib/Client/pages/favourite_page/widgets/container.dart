import 'package:car_wash_app/Controllers/favourite_service__state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavouriteCategoryContainerInfo extends ConsumerWidget {
  final String carWashCategoryName;
  final double carWashCategoryPrice;
  final double rating;
  const FavouriteCategoryContainerInfo(
      {super.key,
      required this.carWashCategoryName,
      required this.carWashCategoryPrice,
      required this.rating});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 20,
            child: FittedBox(
              child: Text(
                textAlign: TextAlign.center,
                carWashCategoryName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )),
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 20,
            child: Row(
              children: [
                const Spacer(
                  flex: 10,
                ),
                Expanded(flex: 20, child: FittedBox(child: Text("$rating"))),
                const Expanded(
                    flex: 10,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    )),
                const Spacer(
                  flex: 50,
                ),
              ],
            )),
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 20,
            child: Row(
              children: [
                const Spacer(
                  flex: 10,
                ),
                Expanded(
                    flex: 80,
                    child: Text(
                      "$carWashCategoryPrice\$",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange),
                    )),
                const Spacer(
                  flex: 10,
                ),
              ],
            )),
        const Spacer(
          flex: 20,
        )
      ],
    );
  }
}
