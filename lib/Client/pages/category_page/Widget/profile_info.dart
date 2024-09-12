import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/search_page.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/controller/profile_pic_controller.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/view/notification_page.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/dialog_for_showing_profile_image.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class ProfilePic extends ConsumerWidget {
  final String userProfilePic;
  const ProfilePic({super.key, required this.userProfilePic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(profilePicProvider);

    return InkWell(
      onTap: () {
        log("State = $state");
        if (state == "") {
          dialogForShowingProfileImage(context, userProfilePic, false);
        } else {
          log("State = $state");
          dialogForShowingProfileImage(context, state, true);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: userProfilePic == ""
                    ? AssetImage(emptyImage)
                    : CachedNetworkImageProvider(userProfilePic),
                fit: BoxFit.fill)),
        child: state != ""
            ? Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(state)), fit: BoxFit.fill)),
              )
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
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

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
            child: FittedBox(
              child: FittedBox(
                child: Text(
                  userLocation == "" ? "Location" : userLocation,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }
}

class NotificationIcon extends ConsumerWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TouchRippleEffect(
      rippleColor: Colors.yellow,
      onTap: () async {
        Navigator.pushNamed(context, NotificationPage.pageName);
      },
      child: Opacity(
          opacity: 0.5,
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: const Icon(Icons.notifications),
          )),
    );
  }
}

class HomePageSearchBar extends ConsumerWidget {
  const HomePageSearchBar({super.key});

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
