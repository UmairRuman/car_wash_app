import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Client/pages/chooser_page/controller/image_controller.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class ChooserPageUserName extends StatelessWidget {
  const ChooserPageUserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 60,
            child: Text(
              "Welcome ${FirebaseAuth.instance.currentUser!.displayName ?? ""}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        const Spacer(
          flex: 20,
        ),
      ],
    );
  }
}

class ChooserPageUserPic extends ConsumerWidget {
  const ChooserPageUserPic({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var imagePath = ref.watch(profilePageImageStateProvider);
    log(imagePath);
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: imagePath == ""
                  ? AssetImage(emptyImage)
                  : FileImage(File(imagePath)),
              fit: BoxFit.scaleDown)),
    );
  }
}

class EditIcon extends ConsumerWidget {
  const EditIcon({super.key});
  //Function
  Future<void> onClickEditIcon(WidgetRef ref) async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
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
        ref
            .read(profilePageImageStateProvider.notifier)
            .onReciveImagePathFromCloud(croppedFile.path);
        FirebaseStorage.instance
            .ref()
            .child("Images")
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child("userImage")
            .putFile(File(croppedFile.path))
            .then(
          (snapshot) async {
            var imagePath = await snapshot.ref.getDownloadURL();
            log("Image Path $imagePath");

            ref
                .read(userAdditionStateProvider.notifier)
                .listOfUserInfo[MapForUserInfo.profilePicUrl] = imagePath;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TouchRippleEffect(
      rippleColor: Colors.yellow,
      borderRadius: BorderRadius.circular(150),
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
          await onClickEditIcon(ref);
        }
      },
      child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(255, 21, 113, 188)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          )),
    );
  }
}
