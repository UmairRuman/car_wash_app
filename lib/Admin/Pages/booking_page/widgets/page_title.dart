import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideBookingPageTitle extends ConsumerWidget {
  const AdminSideBookingPageTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 50,
            child: Row(
              children: [
                const Expanded(
                  flex: 80,
                  child: FittedBox(
                      child: Text(
                    "All Bookings",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
                Expanded(flex: 20, child: Image.asset(bookingPageImage))
              ],
            )),
        const Spacer(
          flex: 15,
        ),
        Expanded(
            flex: 25,
            child: IconButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day - 1),
                      maxTime: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day + 7),
                      onChanged: (date) {}, onConfirm: (date) {
                    //Assinging the date to a variable to show booings of that date
                    ref
                            .read(bookingsIntialStateProvider.notifier)
                            .dateTimeForFilter =
                        DateTime(date.year, date.month, date.day);

                    ref
                        .read(bookingsIntialStateProvider.notifier)
                        .getAllInitialBookings();
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                icon: const Icon(
                  Icons.date_range_outlined,
                  size: 40,
                  color: Colors.white,
                ))),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
