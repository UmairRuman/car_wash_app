import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class AdminProfilePic extends StatelessWidget {
  final String userProfilePic;
  const AdminProfilePic({super.key, required this.userProfilePic});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: userProfilePic == ""
                  ? AssetImage(profilePic)
                  : NetworkImage(userProfilePic),
              fit: BoxFit.fill)),
    );
  }
}

class AdminHomePageUserLocation extends StatelessWidget {
  final String userLocation;
  const AdminHomePageUserLocation({super.key, required this.userLocation});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            flex: 15,
            child: Icon(
              Icons.location_on_sharp,
              color: Colors.red,
            )),
        Expanded(
            flex: 85,
            child: Text(
              userLocation == "" ? "Bahwalpur,Pakistan" : userLocation,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}

class AdminNotificationIcon extends StatelessWidget {
  const AdminNotificationIcon({super.key});

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

class AdminHomePageSearchBar extends StatelessWidget {
  const AdminHomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      leading: Icon(Icons.search),
      hintText: "Search",
    );
  }
}

class AdminUserNameText extends StatelessWidget {
  final String userName;
  const AdminUserNameText({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        userName == "" ? "No Name" : userName,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }
}
