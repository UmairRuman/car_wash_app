import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Admin/Pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/controller/profile_pic_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

// Profile picture edit icon
class AdminProfilePageEditIcon extends ConsumerWidget {
  const AdminProfilePageEditIcon({super.key});

  Future<void> _pickAndCropImage(BuildContext context, WidgetRef ref) async {
    // Pick the image from the gallery
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        // Crop the image
        var croppedFile = await ImageCropper().cropImage(
            sourcePath: pickedFile.path,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 0.5),
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'Crop Image',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                hideBottomControls: true,
                lockAspectRatio: false,
              ),
            ]);

        if (croppedFile != null) {
          // Update the profile picture locally for instant display
          ref
              .read(profilePicProvider.notifier)
              .onChangeProfilePic(croppedFile.path);

          // Upload the image to Firebase Storage
          var snapshot = await FirebaseStorage.instance
              .ref()
              .child("Images")
              .child(FirebaseAuth.instance.currentUser!.uid)
              .child("userImage")
              .putFile(File(croppedFile.path));

          // Get the download URL
          var imagePath = await snapshot.ref.getDownloadURL();

          // Update the Firestore with the new profile image URL
          await ref
              .read(adminSideEditProfileInfoProvider.notifier)
              .onUpdateImage(imagePath, context);
        }
      }
    } catch (e) {
      log("Error in cropping image ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TouchRippleEffect(
      rippleColor: Colors.orange,
      onTap: () async {
        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult[0] == ConnectivityResult.none) {
          // No internet connection
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No internet connection'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          _pickAndCropImage(context, ref);
        }
      },
      child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.edit,
              color: Color.fromARGB(255, 21, 113, 188),
            ),
          )),
    );
  }
}
