import 'package:flutter/material.dart';

class BookingPageTitle extends StatelessWidget {
  const BookingPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 60,
            child: FittedBox(
                child: Text(
              "Booking Page ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ))),
        Spacer(
          flex: 20,
        )
      ],
    );
  }
}
