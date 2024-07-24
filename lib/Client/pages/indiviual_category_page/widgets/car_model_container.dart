import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CarModelContainer extends ConsumerWidget {
  final List<Car> listOfCars;
  const CarModelContainer({super.key, required this.listOfCars});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = -1;
    bool isSelected = false;
    return StatefulBuilder(
      builder: (context, setState) => LayoutBuilder(
        builder: (context, constraints) => AnimationLimiter(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfCars.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(seconds: 1),
                child: SlideAnimation(
                  horizontalOffset: -50,
                  child: FadeInAnimation(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, bottom: 5, top: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected && selectedIndex == index) {
                              isSelected = false;
                            } else {
                              isSelected = true;
                            }
                            selectedIndex = index;
                          });
                          ref.read(bookingStateProvider.notifier).carPrice =
                              listOfCars[selectedIndex].price;
                          ref.read(bookingStateProvider.notifier).carType =
                              listOfCars[selectedIndex].carName;
                          ref
                                  .read(bookingStateProvider.notifier)
                                  .isCarAssetImage =
                              listOfCars[selectedIndex].isAsset;
                          ref.read(bookingStateProvider.notifier).carImagePath =
                              listOfCars[selectedIndex].url;
                        },
                        child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth / 3,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 249, 248, 248),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: isSelected && selectedIndex == index
                                  ? Border.all(color: Colors.blue, width: 3)
                                  : const Border(),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 143, 193, 234),
                                    offset: Offset(3, 3),
                                    blurRadius: 3)
                              ]),
                          child: Stack(clipBehavior: Clip.none, children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 55,
                                    child: (listOfCars[index].isAsset
                                        ? Image.asset(listOfCars[index].url)
                                        : Image.network(
                                            listOfCars[index].url))),
                                Expanded(
                                    flex: 25,
                                    child: Text(
                                      listOfCars[index].carName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                  flex: 15,
                                  child: Text(
                                    listOfCars[index].price,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                const Spacer(
                                  flex: 5,
                                )
                              ],
                            ),
                            if (isSelected && selectedIndex == index)
                              Positioned(
                                top: -5,
                                right: -5,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check,
                                      color: Colors.white, size: 20.0),
                                ),
                              ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
