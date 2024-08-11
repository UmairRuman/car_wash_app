import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/NotificationPage/view/notification_page.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/dialog_for_showing_profile_image.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminProfilePic extends StatelessWidget {
  final String userProfilePic;
  const AdminProfilePic({super.key, required this.userProfilePic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dialogForShowingProfileImage(context, userProfilePic);
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: userProfilePic == ""
                    ? AssetImage(profilePic)
                    : CachedNetworkImageProvider(userProfilePic),
                fit: BoxFit.cover)),
        child: userProfilePic == ""
            ? null
            : CachedNetworkImage(
                imageUrl: userProfilePic,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ),
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
            child: FittedBox(
              child: Text(
                userLocation == "" ? "Location" : userLocation,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
  }
}

class AdminNotificationIcon extends ConsumerWidget {
  const AdminNotificationIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MessageDatabase messageDatabase = MessageDatabase();
    return Opacity(
        opacity: 0.5,
        child: InkWell(
          onTap: () async {
            await ref.read(messageStateProvider.notifier).intialMessages();
            Navigator.of(context).pushNamed(
              AdminSideNotificationPage.pageName,
            );
          },
          child: Stack(children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Icon(Icons.notifications),
            ),
            Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ))
          ]),
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
