import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/Client/pages/booking_page/widgets/booked_info_container.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainContainer extends ConsumerWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listOfBookings = ref
        .read(bookingsIntialStateProvider.notifier)
        .intialListOfBookingsForClient;
    var state = ref.watch(bookingStateProvider);
    return Builder(builder: (context) {
      if (state is BookingIntialState) {
        return LayoutBuilder(
          builder: (context, constraints) => Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView.builder(
              itemCount: listOfBookings.length,
              itemBuilder: (context, index) {
                return BookedInfoContainer(
                  height: constraints.maxHeight / 4,
                  width: constraints.maxWidth / 3,
                  bookingDate: listOfBookings[index].bookingDate,
                  bookingServiceName: listOfBookings[index].serviceName,
                  bookingStatus: listOfBookings[index].bookingStatus,
                  imagePath: listOfBookings[index].serviceImageUrl,
                  timeSlot: listOfBookings[index].timeSlot,
                  washPrice: listOfBookings[index].price,
                );
              },
            ),
          ),
        );
      } else if (state is BookingLoadingState) {
        return const Scaffold(
            backgroundColor: Colors.blue,
            body: SpinKitCubeGrid(
              color: Colors.white,
              size: 40,
            ));
      } else if (state is BookingLoadedState) {
        return LayoutBuilder(
          builder: (context, constraints) => Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView.builder(
              itemCount: state.listOfClientBookings.length,
              itemBuilder: (context, index) {
                return BookedInfoContainer(
                  height: constraints.maxHeight / 4,
                  width: constraints.maxWidth / 3,
                  bookingDate: state.listOfClientBookings[index].bookingDate,
                  bookingServiceName:
                      state.listOfClientBookings[index].serviceName,
                  bookingStatus:
                      state.listOfClientBookings[index].bookingStatus,
                  imagePath: state.listOfClientBookings[index].serviceImageUrl,
                  timeSlot: state.listOfClientBookings[index].timeSlot,
                  washPrice: state.listOfClientBookings[index].price,
                );
              },
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
