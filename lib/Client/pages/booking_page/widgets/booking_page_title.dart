import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingPageTitle extends ConsumerWidget {
  const BookingPageTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        const Expanded(
            flex: 50,
            child: FittedBox(
                child: Text(
              "All Bookings",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ))),
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
