import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_time_slot_dialog.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdminSideTimeSlot extends ConsumerWidget {
  const AdminSideTimeSlot({super.key});

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
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(15, 15))),
                            child: Text(
                              state.list[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isClicked && selectedIndex == index
                                      ? Colors.white
                                      : Colors.black),
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

class AdminSideTextChooseTimeSlot extends StatelessWidget {
  final String serviceName;
  final int serviceId;
  final bool isFavourite;
  const AdminSideTextChooseTimeSlot(
      {super.key,
      required this.serviceId,
      required this.serviceName,
      required this.isFavourite});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
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
        const Spacer(
          flex: 32,
        ),
        Expanded(
          flex: 15,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                dialogForEditTimeSlot(
                    context, serviceName, serviceId, isFavourite);
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 201, 218, 232),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(Icons.timer_sharp)),
            ),
          ),
        ),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }
}
