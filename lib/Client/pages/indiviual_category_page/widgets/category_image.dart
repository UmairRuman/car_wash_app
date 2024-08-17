import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class IndiviualCategoryImage extends StatelessWidget {
  final String imagePath;
  final String description;
  final bool isAssetImage;
  final String adminPhoneNumber;
  const IndiviualCategoryImage(
      {super.key,
      required this.imagePath,
      required this.description,
      required this.isAssetImage,
      required this.adminPhoneNumber});

  @override
  Widget build(BuildContext context) {
    log("IS Asset Image in Indiviual category image $isAssetImage");
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
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: isAssetImage
                    ? Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : CachedNetworkImage(
                        imageUrl: imagePath,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Image.asset(emptyImage),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),
            ),
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
                              flex: 20,
                              child: Icon(
                                Icons.phone,
                                color: Colors.green,
                              )),
                          Expanded(
                              flex: 80,
                              child: FittedBox(
                                  child: Text(
                                adminPhoneNumber,
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
