import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/widgets/booked_info_container.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/widgets/intial_bookings_widget.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminSideMainContainer extends ConsumerWidget {
  const AdminSideMainContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(bookingStateProvider);
    log("Admin Side main Container rebuild");
    return Builder(builder: (context) {
      if (state is BookingIntialState) {
        return const Scaffold(
            body: Center(child: const AdminSideIntialBookings()));
      } else if (state is BookingLoadingState) {
        return const Scaffold(
            backgroundColor: Colors.blue,
            body: SpinKitCubeGrid(
              color: Colors.white,
              size: 40,
            ));
      } else if (state is BookingLoadedState) {
        return Scaffold(
          body: Center(
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ListView.builder(
                  itemCount: state.listOfAdminBookings.length,
                  itemBuilder: (context, index) {
                    return AdminBookedInfoContainer(
                      bookerPhoneNo:
                          state.listOfAdminBookings[index].bookerPhoneNo,
                      carName: state.listOfAdminBookings[index].carType,
                      bookerName: state.listOfAdminBookings[index].bookerName,
                      height: constraints.maxHeight / 4,
                      width: constraints.maxWidth / 3,
                      bookingDate: state.listOfAdminBookings[index].bookingDate,
                      bookingServiceName:
                          state.listOfAdminBookings[index].serviceName,
                      bookingStatus:
                          state.listOfAdminBookings[index].bookingStatus,
                      imagePath:
                          state.listOfAdminBookings[index].serviceImageUrl,
                      timeSlot: state.listOfAdminBookings[index].timeSlot,
                      washPrice: state.listOfAdminBookings[index].price,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      } else {
        String error = (state as BookingErrorState).error;
        return Scaffold(
          body: Center(child: Text(error)),
        );
      }
    });
  }
}
