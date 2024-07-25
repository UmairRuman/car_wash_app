import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/Client/pages/booking_page/widgets/booked_info_container.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MainContainer extends ConsumerWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(bookingStateProvider);
    var listOfBookings =
        ref.read(bookingsIntialStateProvider.notifier).listOfBookings;
    return Builder(builder: (context) {
      if (state is BookingIntialState) {
        return LayoutBuilder(
          builder: (context, constraints) => Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: listOfBookings.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(seconds: 1),
                    child: SlideAnimation(
                      horizontalOffset: 50,
                      child: FadeInAnimation(
                        child: BookedInfoContainer(
                          height: constraints.maxHeight / 4,
                          width: constraints.maxWidth / 3,
                          bookingDate: listOfBookings[index].bookingDate,
                          bookingServiceName: listOfBookings[index].serviceName,
                          bookingStatus: listOfBookings[index].bookingStatus,
                          imagePath: listOfBookings[index].serviceImageUrl,
                          timeSlot: listOfBookings[index].timeSlot,
                          washPrice: listOfBookings[index].price,
                        ),
                      ),
                    ),
                  );
                },
              ),
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
              itemCount: state.listOfAdminBookings.length,
              itemBuilder: (context, index) {
                return BookedInfoContainer(
                  height: constraints.maxHeight / 4,
                  width: constraints.maxWidth / 3,
                  bookingDate: state.listOfAdminBookings[index].bookingDate,
                  bookingServiceName:
                      state.listOfAdminBookings[index].serviceName,
                  bookingStatus: state.listOfAdminBookings[index].bookingStatus,
                  imagePath: state.listOfAdminBookings[index].serviceImageUrl,
                  timeSlot: state.listOfAdminBookings[index].timeSlot,
                  washPrice: state.listOfAdminBookings[index].price,
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
