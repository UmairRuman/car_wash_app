import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/controller/profile_pic_controller.dart'; // Ensure this file exists and is correctly managing state.
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePagePic extends ConsumerWidget {
  final String profileImageUrl;
  const ProfilePagePic({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the profilePicProvider state, which stores the path to the newly selected image (if any)
    var state = ref.watch(profilePicProvider);

    // Determine whether to show the network image, default empty image, or a newly picked image
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white),
        shape: BoxShape.circle,
      ),
      child: state != "" // Check if the user has picked a new image
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.white),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: FileImage(
                      File(state)), // Show the newly picked image immediately
                  fit: BoxFit.fill,
                ),
              ),
            )
          : profileImageUrl ==
                  "" // If no new image is picked, check if profileImageUrl is empty
              ? Image.asset(
                  emptyImage) // Show the default empty image if profileImageUrl is empty
              : CachedNetworkImage(
                  imageUrl:
                      profileImageUrl, // Show the network image if profileImageUrl is available
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
    );
  }
}

class AdminSideUserName extends StatelessWidget {
  const AdminSideUserName({super.key});

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: Text(
        "Umair Ruman",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
