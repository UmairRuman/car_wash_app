import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class FavouritePageTitle extends StatelessWidget {
  const FavouritePageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 15,
        ),
        Expanded(
            flex: 55,
            child: FittedBox(
              fit: BoxFit.none,
              child: Text(
                stringFavouriteCarWashServices,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )),
        const Spacer(
          flex: 40,
        )
      ],
    );
  }
}
