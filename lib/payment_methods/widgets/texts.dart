import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class BookingServiceText extends StatelessWidget {
  final String serviceName;
  const BookingServiceText({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: FittedBox(
                child: Text(
              "$serviceName Booking",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ))),
        const Spacer(
          flex: 10,
        )
      ],
    );
  }
}

class BookingDateText extends StatelessWidget {
  final DateTime bookingDate;
  const BookingDateText({super.key, required this.bookingDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 15,
        ),
        Expanded(flex: 20, child: Image.asset(dateImage)),
        const Spacer(
          flex: 20,
        ),
        Expanded(flex: 30, child: Text(bookingDate.toString())),
        const Spacer(
          flex: 15,
        ),
      ],
    );
  }
}

class BookingSlotText extends StatelessWidget {
  final String bookingSlot;
  const BookingSlotText({super.key, required this.bookingSlot});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 15,
        ),
        Expanded(flex: 20, child: Image.asset(slotImage)),
        const Spacer(
          flex: 20,
        ),
        Expanded(flex: 30, child: Text(bookingSlot)),
        const Spacer(
          flex: 15,
        ),
      ],
    );
  }
}

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 80,
            child: FittedBox(
                child: Text(
              "Pay and Confirm Your Booking",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))),
        Spacer(
          flex: 10,
        )
      ],
    );
  }
}

class ChoosePaymmentMethodText extends StatelessWidget {
  const ChoosePaymmentMethodText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 25,
        ),
        Expanded(
            flex: 50,
            child: FittedBox(
                child: Text(
              "Choose Payment method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ))),
        Spacer(
          flex: 25,
        )
      ],
    );
  }
}
