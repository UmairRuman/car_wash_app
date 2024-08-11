import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class AdminSideProfilePagePic extends StatelessWidget {
  final String profileImageUrl;
  const AdminSideProfilePagePic({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.white),
          shape: BoxShape.circle,
          image: DecorationImage(
              image: CachedNetworkImageProvider(profileImageUrl),
              fit: BoxFit.none)),
      child: profileImageUrl == ""
          ? Image.asset(emptyImage)
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
                    fit: BoxFit.cover,
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
