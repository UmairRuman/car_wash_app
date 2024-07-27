import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ClientSideTimeSlots extends ConsumerWidget {
  const ClientSideTimeSlots({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = -1;
    bool isClicked = false;
    var state = ref.watch(timeSlotsStateProvider);
    return LayoutBuilder(builder: (context, constraints) {
      if (state is TimeSlotInitialState) {
        return const Center(
          child: Text("No Time slot added"),
        );
      } else if (state is TimeSlotLoadedState) {
        return StatefulBuilder(
          builder: (context, setState) => AnimationLimiter(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                log("list of String ${state.list[index]}");
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: SlideAnimation(
                    verticalOffset: -50,
                    horizontalOffset: 50,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isClicked && selectedIndex == index) {
                                isClicked = false;
                              } else {
                                isClicked = true;
                              }
                              selectedIndex = index;
                            });
                            ref.read(bookingStateProvider.notifier).timeSlot =
                                state.list[selectedIndex];
                          },
                          child: Container(
                            height: constraints.maxHeight / 2,
                            width: constraints.maxWidth / 4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: isClicked && selectedIndex == index
                                    ? Colors.blue
                                    : Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 167, 204, 234),
                                      offset: Offset(3, 3),
                                      blurRadius: 3)
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(15, 15))),
                            child: Column(
                              children: [
                                Text(
                                  state.list[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isClicked && selectedIndex == index
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                const Text(
                                  "Available",
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
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
