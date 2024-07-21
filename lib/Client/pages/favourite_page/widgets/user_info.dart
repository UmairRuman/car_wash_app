import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class FavouritePageUserLocation extends StatelessWidget {
  const FavouritePageUserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            flex: 15,
            child: Icon(
              Icons.location_on_sharp,
              color: Colors.red,
            )),
        Expanded(
            flex: 85,
            child: FittedBox(
              child: Text(
                "Bahwalpur,Pakistan",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
  }
}

class FavouritePageProfilePic extends StatelessWidget {
  const FavouritePageProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(profilePic), fit: BoxFit.cover)),
    );
  }
}

class FavouritePageUserInfo extends StatelessWidget {
  const FavouritePageUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 5,
        ),
        Expanded(flex: 40, child: FavouritePageUserLocation()),
        Spacer(
          flex: 40,
        ),
        Expanded(flex: 10, child: FavouritePageProfilePic()),
        Spacer(
          flex: 5,
        )
      ],
    );
  }
}

class FavouriteCategoryPic extends StatelessWidget {
  final String favouriteCategoryimagePath;
  const FavouriteCategoryPic(
      {super.key, required this.favouriteCategoryimagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(favouriteCategoryimagePath), fit: BoxFit.cover),
          color: const Color.fromARGB(255, 239, 233, 233),
          borderRadius: const BorderRadius.all(Radius.circular(30))),
    );
  }
}
