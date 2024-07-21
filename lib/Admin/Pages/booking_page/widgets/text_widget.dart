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
        Expanded(
            flex: 45,
            child: AdminSideActualBookingDate(bookingDate: bookingDate)),
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
        Expanded(
            flex: 45,
            child: AdminSideActualBookingTimeSlot(timeSlot: timeSlot)),
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
        Expanded(
            flex: 45,
            child: AdminSideActualBookingWashPrice(washPrice: washPrice)),
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
            flex: 45,
            child: AdminSideActualBookingStatus(bookingStatus: bookingStatus)),
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
            child: AdminSideActualBookedServiceName(
                serviceName: bookingServiceName)),
      ],
    );
  }
}

class AdminSideActualBookingDate extends StatelessWidget {
  final String bookingDate;
  const AdminSideActualBookingDate({super.key, required this.bookingDate});

  @override
  Widget build(BuildContext context) {
    return Text(
      bookingDate,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
    );
  }
}

class AdminSideActualBookingTimeSlot extends StatelessWidget {
  final String timeSlot;
  const AdminSideActualBookingTimeSlot({super.key, required this.timeSlot});

  @override
  Widget build(BuildContext context) {
    return Text(
      timeSlot,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
    );
  }
}

class AdminSideActualBookingWashPrice extends StatelessWidget {
  final String washPrice;
  const AdminSideActualBookingWashPrice({super.key, required this.washPrice});

  @override
  Widget build(BuildContext context) {
    return Text(
      washPrice,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
    );
  }
}

class AdminSideActualBookingStatus extends StatelessWidget {
  final String bookingStatus;
  const AdminSideActualBookingStatus({super.key, required this.bookingStatus});

  @override
  Widget build(BuildContext context) {
    return Text(
      bookingStatus,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
    );
  }
}

class AdminSideActualBookedServiceName extends StatelessWidget {
  final String serviceName;
  const AdminSideActualBookedServiceName(
      {super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Text(
      serviceName,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
    );
  }
}
