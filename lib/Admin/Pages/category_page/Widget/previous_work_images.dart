import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class AdminPreviousWorkImages extends StatelessWidget {
  const AdminPreviousWorkImages({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < listOfPreviousWorkImages.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth / 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 75,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage(listOfPreviousWorkImages[i]))),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Row(children: [
                          const Spacer(
                            flex: 5,
                          ),
                          Expanded(
                              flex: 50,
                              child: FittedBox(
                                  child: Text(listOfCategoryName[i]))),
                          const Spacer(
                            flex: 5,
                          ),
                          const Expanded(
                              flex: 40,
                              child: Row(
                                children: [
                                  Spacer(
                                    flex: 20,
                                  ),
                                  Expanded(
                                    flex: 30,
                                    child: Text("5.0"),
                                  ),
                                  Expanded(
                                    flex: 30,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 20,
                                  ),
                                ],
                              ))
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
