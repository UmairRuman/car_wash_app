import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/decorations/favourite_page_decorations.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:car_wash_app/utils/lists.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class FavouriteServiceList extends StatelessWidget {
  const FavouriteServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: listOfCategoryName.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight / 5,
              decoration: favouriteCategoryContainerDecoration,
              child: Row(
                children: [
                  Expanded(
                      flex: 40,
                      child: FavouriteCategoryPic(
                          favouriteCategoryimagePath:
                              listOfPreviousWorkImages[index])),
                  Expanded(
                      flex: 30,
                      child: FavouriteCategoryContainerInfo(
                          carWashCategoryPrice: listOfServicePrices[index],
                          carWashCategoryName: listOfCategoryName[index])),
                  const Expanded(
                      flex: 30, child: FavouriteCategoryBookButton()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FavouriteCategoryContainerInfo extends StatelessWidget {
  final String carWashCategoryName;
  final String carWashCategoryPrice;
  const FavouriteCategoryContainerInfo(
      {super.key,
      required this.carWashCategoryName,
      required this.carWashCategoryPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 20,
            child: FittedBox(
              child: Text(
                textAlign: TextAlign.center,
                carWashCategoryName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )),
        const Spacer(
          flex: 5,
        ),
        const Expanded(
            flex: 20,
            child: Row(
              children: [
                Spacer(
                  flex: 10,
                ),
                Expanded(flex: 20, child: FittedBox(child: Text("5.0"))),
                Expanded(
                    flex: 10,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    )),
                Spacer(
                  flex: 50,
                ),
              ],
            )),
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 20,
            child: Row(
              children: [
                const Spacer(
                  flex: 10,
                ),
                Expanded(
                    flex: 80,
                    child: Text(
                      carWashCategoryPrice,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange),
                    )),
                const Spacer(
                  flex: 10,
                ),
              ],
            )),
        const Spacer(
          flex: 20,
        )
      ],
    );
  }
}

class FavouriteCategoryPic extends StatelessWidget {
  final String favouriteCategoryimagePath;
  const FavouriteCategoryPic(
      {super.key, required this.favouriteCategoryimagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(favouriteCategoryimagePath), fit: BoxFit.cover),
          color: const Color.fromARGB(255, 239, 233, 233),
          borderRadius: const BorderRadius.all(Radius.circular(30))),
    );
  }
}

class FavouriteCategoryBookButton extends StatelessWidget {
  const FavouriteCategoryBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 10,
        ),
        const Expanded(
            flex: 10,
            child: Row(
              children: [
                Spacer(
                  flex: 60,
                ),
                Expanded(
                  flex: 20,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                Spacer(
                  flex: 20,
                ),
              ],
            )),
        const Spacer(
          flex: 55,
        ),
        Expanded(
          flex: 25,
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: const FittedBox(
                  fit: BoxFit.none,
                  child: Text(
                    stringBookButton,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
