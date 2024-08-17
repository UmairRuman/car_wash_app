import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/widgets/booked_info_container.dart';
import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdminSideIntialBookings extends ConsumerWidget {
  const AdminSideIntialBookings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("Intial Booking UI rebuild");
    var finalIntialListOfBooking =
        ref.read(bookingsIntialStateProvider.notifier).finalListForAdmin;
    ref.watch(bookingsIntialStateProvider);
    return StatefulBuilder(
        builder: (context, setState) => Builder(builder: (context) {
              return Builder(builder: (context) {
                if (finalIntialListOfBooking.isEmpty) {
                  return const Scaffold(
                      body: Center(child: Text("No bookings found Yet")));
                }

                return LayoutBuilder(
                  builder: (context, constraints) => Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: finalIntialListOfBooking.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(seconds: 1),
                            child: SlideAnimation(
                              horizontalOffset: 50,
                              child: FadeInAnimation(
                                child: AdminBookedInfoContainer(
                                  bookerPhoneNo: finalIntialListOfBooking[index]
                                      .bookerPhoneNo,
                                  carName:
                                      finalIntialListOfBooking[index].carType,
                                  bookerName: finalIntialListOfBooking[index]
                                      .bookerName,
                                  height: constraints.maxHeight / 4,
                                  width: constraints.maxWidth / 3,
                                  bookingDate: finalIntialListOfBooking[index]
                                      .carWashdate,
                                  bookingServiceName:
                                      finalIntialListOfBooking[index]
                                          .serviceName,
                                  bookingStatus: finalIntialListOfBooking[index]
                                      .bookingStatus,
                                  imagePath: finalIntialListOfBooking[index]
                                      .serviceImageUrl,
                                  timeSlot:
                                      finalIntialListOfBooking[index].timeSlot,
                                  washPrice:
                                      finalIntialListOfBooking[index].price,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              });
            }));
  }
}
