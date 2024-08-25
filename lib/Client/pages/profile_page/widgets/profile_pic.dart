import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/controller/profile_pic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePagePic extends ConsumerWidget {
  final String profileImageUrl;
  const ProfilePagePic({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(profilePicProvider);
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.white),
            shape: BoxShape.circle,
            image: DecorationImage(
                image: CachedNetworkImageProvider(profileImageUrl),
                fit: BoxFit.fill)),
        child: state != ""
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.white),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(state)), fit: BoxFit.fill)),
              )
            : CachedNetworkImage(
                imageUrl: profileImageUrl,
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
              ));
  }
}

class UserName extends StatelessWidget {
  final String userName;
  const UserName({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        userName,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
