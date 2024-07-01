import 'package:car_wash_app/utils/images_path.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image:
              DecorationImage(image: AssetImage(profilePic), fit: BoxFit.fill)),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      stringUserName,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class HomePageUserLocation extends StatelessWidget {
  const HomePageUserLocation({super.key});

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
            child: Text(
              "Bahwalpur,Pakistan",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.5,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: const Icon(Icons.notifications),
        ));
  }
}

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      leading: Icon(Icons.search),
      hintText: "Search",
    );
  }
}

class UserNameText extends StatelessWidget {
  const UserNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        stringUserName,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }
}
