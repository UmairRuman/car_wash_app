import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_service_info.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideIndiviualCategoryImageAndDescription extends ConsumerWidget {
  final String imagePath;
  final String description;
  final String serviceName;
  final int serviceId;
  final bool isAssetImage;
  final bool isFavourite;
  const AdminSideIndiviualCategoryImageAndDescription(
      {super.key,
      required this.isFavourite,
      required this.isAssetImage,
      required this.imagePath,
      required this.description,
      required this.serviceId,
      required this.serviceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    Row(
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
                    const Spacer(
                      flex: 40,
                    ),
                    Expanded(
                      flex: 30,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) => InkWell(
                            onTap: () {
                              dialogForEdditingServiceImageAndDescription(
                                  context,
                                  serviceName,
                                  serviceId,
                                  imagePath,
                                  ref,
                                  isFavourite);
                            },
                            child: Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: const FittedBox(
                                fit: BoxFit.none,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
