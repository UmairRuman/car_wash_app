import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/Client/pages/booking_page/widgets/booked_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntialBookingStateWidget extends ConsumerWidget {
  const IntialBookingStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var intialListOfBookings = ref
        .read(bookingsIntialStateProvider.notifier)
        .intialListOfBookingsForClient;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView.builder(
          itemCount: intialListOfBookings.length,
          itemBuilder: (context, index) {
            return BookedInfoContainer(
              height: constraints.maxHeight / 4,
              width: constraints.maxWidth / 3,
              bookingDate: intialListOfBookings[index].bookingDate,
              bookingServiceName: intialListOfBookings[index].serviceName,
              bookingStatus: intialListOfBookings[index].bookingStatus,
              imagePath: intialListOfBookings[index].serviceImageUrl,
              timeSlot: intialListOfBookings[index].timeSlot,
              washPrice: intialListOfBookings[index].price,
            );
          },
        ),
      ),
    );
  }
}
