import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

void dialogForShowingProfileImage(BuildContext context, String userProfilePic) {
  showDialog(
    context: context,
    builder: (context) {
      var screenWidth = MediaQuery.of(context).size.width;
      var screenHeight = MediaQuery.of(context).size.height;
      return Container(
        height: screenHeight / 3,
        width: screenWidth / 3,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: userProfilePic == ""
                    ? AssetImage(emptyImage)
                    : CachedNetworkImageProvider(userProfilePic),
                fit: BoxFit.fill)),
        child: userProfilePic == ""
            ? null
            : CachedNetworkImage(
                imageUrl: userProfilePic,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  height: screenHeight / 3,
                  width: screenWidth / 3,
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
    },
  );
}
