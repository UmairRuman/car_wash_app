import 'package:car_wash_app/Client/pages/booking_page/widgets/booked_info_container.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/utils/booking_page_resources.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainContainer extends ConsumerWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(bookingStateProvider);
    return Builder(builder: (context) {
      if (state is BookingIntialState) {
        return const Scaffold(
          body: Center(child: Text("No bookings yet")),
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
