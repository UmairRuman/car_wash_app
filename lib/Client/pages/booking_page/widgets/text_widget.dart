import 'package:flutter/material.dart';

class TextBookingDate extends StatelessWidget {
  final String bookingDate;
  const TextBookingDate({super.key, required this.bookingDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Booking Date",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(flex: 45, child: ActualBookingDate(bookingDate: bookingDate)),
      ],
    );
  }
}

class TextBookingTimeSlot extends StatelessWidget {
  final String timeSlot;
  const TextBookingTimeSlot({super.key, required this.timeSlot});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Time Slot",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(flex: 45, child: ActualBookingTimeSlot(timeSlot: timeSlot)),
      ],
    );
  }
}

class TextBookingWashPrice extends StatelessWidget {
  final String washPrice;
  const TextBookingWashPrice({super.key, required this.washPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Wash Price",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(flex: 45, child: ActualBookingWashPrice(washPrice: washPrice)),
      ],
    );
  }
}

class BookingStatus extends StatelessWidget {
  final String bookingStatus;
  const BookingStatus({super.key, required this.bookingStatus});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Booking Status",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: 45, child: ActualBookingStatus(bookingStatus: bookingStatus)),
      ],
    );
  }
}

class BookedServiceName extends StatelessWidget {
  final String bookingServiceName;
  const BookedServiceName({super.key, required this.bookingServiceName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Service Name",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: 45,
            child: ActualBookedServiceName(serviceName: bookingServiceName)),
      ],
    );
  }
}

class ActualBookingDate extends StatelessWidget {
  final String bookingDate;
  const ActualBookingDate({super.key, required this.bookingDate});

  @override
  Widget build(BuildContext context) {
    return bookingDate.length >= 12
        ? FittedBox(
            child: Text(
              bookingDate,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          )
        : Text(
            bookingDate,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          );
  }
}

class ActualBookingTimeSlot extends StatelessWidget {
  final String timeSlot;
  const ActualBookingTimeSlot({super.key, required this.timeSlot});

  @override
  Widget build(BuildContext context) {
    return timeSlot.length >= 12
        ? FittedBox(
            child: Text(
              timeSlot,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          )
        : Text(
            timeSlot,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          );
  }
}

class ActualBookingWashPrice extends StatelessWidget {
  final String washPrice;
  const ActualBookingWashPrice({super.key, required this.washPrice});

  @override
  Widget build(BuildContext context) {
    return washPrice.length >= 12
        ? FittedBox(
            child: Text(
              washPrice,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.red),
            ),
          )
        : Text(
            washPrice,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: Colors.red),
          );
  }
}

class ActualBookingStatus extends StatelessWidget {
  final String bookingStatus;
  const ActualBookingStatus({super.key, required this.bookingStatus});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        bookingStatus,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13, color: Colors.green),
      ),
    );
  }
}

class ActualBookedServiceName extends StatelessWidget {
  final String serviceName;
  const ActualBookedServiceName({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return serviceName.length >= 12
        ? FittedBox(
            child: Text(
              serviceName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          )
        : Text(
            serviceName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          );
  }
}
