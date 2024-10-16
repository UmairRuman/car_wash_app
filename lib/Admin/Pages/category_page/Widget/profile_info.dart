import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/NotificationPage/view/notification_page.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/database/message_database.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/search_page.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/controller/profile_pic_controller.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/dialog_for_showing_profile_image.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class AdminProfilePic extends ConsumerWidget {
  final String userProfilePic;
  const AdminProfilePic({super.key, required this.userProfilePic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(profilePicProvider);
    return InkWell(
        onTap: () {
          log("State = $state");
          if (state == "") {
            log("Profile pic url $userProfilePic");
            dialogForShowingProfileImage(context, userProfilePic, false);
          } else {
            dialogForShowingProfileImage(context, state, true);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: state != "" // Check if the user has picked a new image
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(File(
                          state)), // Show the newly picked image immediately
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : userProfilePic ==
                      "" // If no new image is picked, check if profileImageUrl is empty
                  ? Image.asset(
                      emptyImage) // Show the default empty image if profileImageUrl is empty
                  : CachedNetworkImage(
                      imageUrl:
                          userProfilePic, // Show the network image if profileImageUrl is available
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
        ));
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
            child: AutoSizeText(
              userLocation == "" ? "Location" : userLocation,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.white),
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
        child: TouchRippleEffect(
          rippleColor: Colors.yellow,
          onTap: () async {
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

class AdminHomePageSearchBar extends ConsumerWidget {
  const AdminHomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var intialListOfServices =
        ref.read(allServiceDataStateProvider.notifier).intialListOfService;

    return GestureDetector(
      onTap: () {
        // Navigate to the search page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchPage(services: intialListOfServices),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.blue, width: 1.0),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'Search service',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
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
