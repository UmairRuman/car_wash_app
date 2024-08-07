import 'package:flutter/material.dart';

class AdminSideTextBookingDate extends StatelessWidget {
  final DateTime bookingDate;
  const AdminSideTextBookingDate({super.key, required this.bookingDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Booking Date",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
            flex: 45,
            child: AdminSideActualBookingDate(
                bookingDate:
                    "${bookingDate.day}-${bookingDate.month}-${bookingDate.year}")),
      ],
    );
  }
}

class AdminSideTextBookingTimeSlot extends StatelessWidget {
  final String timeSlot;
  const AdminSideTextBookingTimeSlot({super.key, required this.timeSlot});

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

class AdminSideTextBookingWashPrice extends StatelessWidget {
  final String washPrice;
  const AdminSideTextBookingWashPrice({super.key, required this.washPrice});

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
            child: AdminSideActualBookingWashPrice(
              washPrice: washPrice,
            )),
      ],
    );
  }
}

class AdminSideBookingStatus extends StatelessWidget {
  final String bookingStatus;
  const AdminSideBookingStatus({super.key, required this.bookingStatus});

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

class AdminSideBookedServiceName extends StatelessWidget {
  final String bookingServiceName;
  const AdminSideBookedServiceName(
      {super.key, required this.bookingServiceName});

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

class AdminSideBookerName extends StatelessWidget {
  final String bookerName;
  const AdminSideBookerName({super.key, required this.bookerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Book Owner",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: 45, child: AdminSideActualBookerName(bookerName: bookerName)),
      ],
    );
  }
}

class AdminSideCarName extends StatelessWidget {
  final String carName;
  const AdminSideCarName({super.key, required this.carName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 55,
          child: Text(
            "Car Type",
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(flex: 45, child: AdminSideActualCarName(carName: carName)),
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
      style: const TextStyle(fontSize: 13, color: Colors.red),
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

class AdminSideActualBookerName extends StatelessWidget {
  final String bookerName;
  const AdminSideActualBookerName({super.key, required this.bookerName});

  @override
  Widget build(BuildContext context) {
    return Text(
      bookerName,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13),
    );
  }
}

class AdminSideActualCarName extends StatelessWidget {
  final String carName;
  const AdminSideActualCarName({super.key, required this.carName});

  @override
  Widget build(BuildContext context) {
    return Text(
      carName,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13, color: Colors.green),
    );
  }
}
