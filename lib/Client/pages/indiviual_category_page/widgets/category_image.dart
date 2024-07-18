import 'dart:io';

import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndiviualCategoryImage extends StatelessWidget {
  final String imagePath;
  final String description;
  final bool isAssetImage;
  const IndiviualCategoryImage(
      {super.key,
      required this.imagePath,
      required this.description,
      required this.isAssetImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(3, 3),
                  color: Color.fromARGB(255, 151, 188, 219),
                  blurRadius: 3)
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Expanded(
                flex: 30,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: isAssetImage
                              ? AssetImage(imagePath)
                              : imagePath == ""
                                  ? AssetImage(emptyImage)
                                  : NetworkImage(imagePath),
                          fit: BoxFit.fill)),
                )),
            const Spacer(
              flex: 5,
            ),
            Expanded(flex: 45, child: Text(description)),
            Expanded(
                flex: 20,
                child: Column(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 25,
                              child: Icon(
                                Icons.phone,
                                color: Colors.green,
                              )),
                          Expanded(
                              flex: 75,
                              child: FittedBox(
                                  child: Text(
                                FirebaseAuth.instance.currentUser!.phoneNumber!,
                                style: const TextStyle(
                                    color:
                                        const Color.fromARGB(255, 16, 66, 108)),
                              ))),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 70,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
