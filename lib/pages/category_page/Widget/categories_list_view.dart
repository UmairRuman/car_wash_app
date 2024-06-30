import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
          flex: 80,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfCategoryName.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                      flex: 40, child: Image.asset(listOfCategoryIcons[index])),
                  Expanded(
                      flex: 40,
                      child: FittedBox(
                        child: Text(
                          listOfCategoryName[index],
                        ),
                      ))
                ],
              );
            },
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
