import 'dart:developer';
import 'dart:io';

import 'package:car_wash_app/Admin/Pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfilePageEditIcon extends ConsumerWidget {
  const AdminProfilePageEditIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        log("Is Clicked");
        var file = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (file != null) {
          FirebaseStorage.instance
              .ref()
              .child("Images")
              .child(FirebaseAuth.instance.currentUser!.uid)
              .child("userImage")
              .putFile(File(file.path))
              .then((snapshot) async {
            var imagePath = await snapshot.ref.getDownloadURL();
            await ref
                .read(editProfileInfoProvider.notifier)
                .onUpdateImage(imagePath, context);
          });
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
