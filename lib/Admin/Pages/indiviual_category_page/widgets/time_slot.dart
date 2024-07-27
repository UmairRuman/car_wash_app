import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_time_slot_dialog.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdminSideTimeSlot extends ConsumerStatefulWidget {
  const AdminSideTimeSlot({super.key});

  @override
  ConsumerState<AdminSideTimeSlot> createState() => _AdminSideTimeSlotState();
}

class _AdminSideTimeSlotState extends ConsumerState<AdminSideTimeSlot> {
  // List<FlipController> flipControllers = [];
  // late FlipController secondController;
  late List<FlipCardController> _controller;

  @override
  void initState() {
    super.initState();
    // secondController = FlipController();
    initializeControllers();
  }

  void initializeControllers() {
    final timeSlots = ref.read(timeSlotsStateProvider.notifier).listOfTimeSlots;
    log("Length of list in Init State ${timeSlots.length}");
    _controller = List.generate(timeSlots.length, (_) => FlipCardController());
  }

  @override
  void dispose() {
    // for (var controller in _controller) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = -1;
    final state = ref.watch(timeSlotsStateProvider);
    final selectedDate = ref.read(timeSlotsStateProvider.notifier).currentDate;

    return LayoutBuilder(builder: (context, constraints) {
      if (state is TimeSlotInitialState) {
        return const Center(
          child: Text("No Time slot added"),
        );
      } else if (state is TimeSlotLoadedState) {
        // if (flipControllers.length != state.list.length) {
        //   log("Length of flip controllers in Loaded State ${flipControllers.length}");
        //   log("Length of list in Loaded State ${state.list.length}");
        //   initializeControllers();
        // }

        return AnimationLimiter(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              // log(index.toString());
              // flipControllers[index].dispose();
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(seconds: 1),
                child: SlideAnimation(
                  verticalOffset: -50,
                  horizontalOffset: 50,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FlipCard(
                        controller: _controller[index],
                        side: CardSide.FRONT,
                        direction: FlipDirection.VERTICAL,
                        back: InkWell(
                          onLongPress: () {
                            _controller[index].toggleCard();
                          },
                          child: Container(
                            height: constraints.maxHeight / 2,
                            width: constraints.maxWidth / 4,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 143, 193, 234),
                                  offset: Offset(3, 3),
                                  blurRadius: 3,
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(timeSlotsStateProvider.notifier)
                                    .deleteTimeSlotAtSpecificDate(
                                        index, selectedDate);
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
                        front: InkWell(
                          onLongPress: () {
                            setState(() {
                              _controller[index].toggleCard();
                            });
                          },
                          child: Container(
                            height: constraints.maxHeight / 2,
                            width: constraints.maxWidth / 4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? Colors.blue
                                  : Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 167, 204, 234),
                                  offset: Offset(3, 3),
                                  blurRadius: 3,
                                )
                              ],
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(15, 15)),
                            ),
                            child: Text(
                              state.list[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
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
        );
      } else if (state is TimeSlotErrorState) {
        return Center(
          child: Text(state.error),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class AdminSideTextChooseTimeSlot extends StatelessWidget {
  final String serviceName;
  final String serviceId;
  final bool isFavourite;
  const AdminSideTextChooseTimeSlot({
    super.key,
    required this.serviceId,
    required this.serviceName,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 5),
        const Expanded(
          flex: 35,
          child: FittedBox(
            child: Text(
              stringChooseTimeSlot,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(flex: 10, child: Icon(Icons.arrow_forward)),
        const Spacer(flex: 32),
        Expanded(
          flex: 15,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                dialogForEditTimeSlot(
                    context, isFavourite, serviceId, serviceName);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 201, 218, 232),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Icon(Icons.timer_sharp),
              ),
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
