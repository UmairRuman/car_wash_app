import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/Functions/open_maps.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingPageTitle extends ConsumerWidget {
  const BookingPageTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Expanded(
            flex: 40,
            child: FittedBox(
                child: Text(
              "Your Bookings",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ))),
        const Spacer(
          flex: 30,
        ),
        Expanded(
            flex: 30,
            child: IconButton(
                onPressed: () {
                  openMap(29.395721, 71.683334);
                },
                icon: const Icon(
                  Icons.location_city_outlined,
                  color: Colors.white,
                )))
      ],
    );
  }
}
