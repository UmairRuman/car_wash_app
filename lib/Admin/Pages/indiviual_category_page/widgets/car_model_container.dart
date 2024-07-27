import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdminSideCarModelContainer extends ConsumerStatefulWidget {
  final List<Car> listOfCars;
  final String serviceId;
  final String serviceName;
  const AdminSideCarModelContainer(
      {super.key,
      required this.listOfCars,
      required this.serviceId,
      required this.serviceName});

  @override
  ConsumerState<AdminSideCarModelContainer> createState() =>
      _AdminSideCarModelContainerState();
}

class _AdminSideCarModelContainerState
    extends ConsumerState<AdminSideCarModelContainer> {
  late List<FlipCardController> _controller;

  @override
  void initState() {
    super.initState();
    // secondController = FlipController();
    initializeControllers();
  }

  void initializeControllers() {
    _controller =
        List.generate(widget.listOfCars.length, (_) => FlipCardController());
  }

  @override
  void dispose() {
    // for (var controller in flipControllers) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = -1;
    bool isClickedLong = false;
    return LayoutBuilder(
      builder: (context, constraints) => AnimationLimiter(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.listOfCars.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              duration: const Duration(seconds: 1),
              position: index,
              child: SlideAnimation(
                horizontalOffset: -50,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
                    child: FlipCard(
                      side: CardSide.FRONT,
                      controller: _controller[index],
                      direction: FlipDirection.VERTICAL,
                      //Back Side of Widget
                      back: InkWell(
                        onLongPress: () {
                          _controller[index].toggleCard();
                        },
                        child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth / 3,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 143, 193, 234),
                                    offset: Offset(3, 3),
                                    blurRadius: 3)
                              ]),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(allServiceDataStateProvider.notifier)
                                  .deleteCar(index, widget.serviceId,
                                      widget.serviceName);
                              log("deleted ");
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      //Front Side OF Widget
                      front: InkWell(
                        onLongPress: () {
                          _controller[index].toggleCard();
                        },
                        child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth / 3,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 249, 248, 248),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 143, 193, 234),
                                    offset: Offset(3, 3),
                                    blurRadius: 3)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 55,
                                  child: (widget.listOfCars[index].isAsset
                                      ? Image.asset(
                                          widget.listOfCars[index].url)
                                      : CachedNetworkImage(
                                          imageUrl:
                                              widget.listOfCars[index].url,
                                          placeholder: (context, url) =>
                                              const CupertinoActivityIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ))),
                              Expanded(
                                  flex: 25,
                                  child: Text(
                                    widget.listOfCars[index].carName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                flex: 15,
                                child: Text(
                                  widget.listOfCars[index].price,
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                              const Spacer(
                                flex: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
