import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String userProfilePic;
  const ProfilePic({super.key, required this.userProfilePic});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: userProfilePic == ""
                  ? AssetImage(emptyImage)
                  : NetworkImage(userProfilePic),
              fit: BoxFit.fill)),
    );
  }
}

// class UserName extends StatelessWidget {
//   final String userName;
//   const UserName({super.key, required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       userName == "" ? "UserName" : userName,
//       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     );
//   }
// }

class HomePageUserLocation extends StatelessWidget {
  final String userLocation;
  const HomePageUserLocation({super.key, required this.userLocation});

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
              userLocation == "" ? "Location" : userLocation,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
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
  final String userName;
  const UserNameText({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        userName == "" ? "UserName" : userName,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }
}
