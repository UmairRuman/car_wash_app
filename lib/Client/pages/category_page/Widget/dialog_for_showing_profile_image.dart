import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

void dialogForShowingProfileImage(
    BuildContext context, String userProfilePic, bool isFileImage) {
  showDialog(
    context: context,
    builder: (context) {
      var screenWidth = MediaQuery.of(context).size.width;
      var screenHeight = MediaQuery.of(context).size.height;
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenHeight *
              0.2), // Large border radius to maintain the circular shape
        ),
        backgroundColor: Colors.transparent, // Transparent background
        child: ClipOval(
          child: SizedBox(
            width: screenWidth * 0.5, // Adjust as needed
            height: screenHeight * 0.4, // Adjust as needed
            child: userProfilePic.isEmpty
                ? Image.asset(emptyImage, fit: BoxFit.cover)
                : isFileImage
                    ? Image.file(File(userProfilePic))
                    : CachedNetworkImage(
                        imageUrl: userProfilePic,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
          ),
        ),
      );
    },
  );
}
