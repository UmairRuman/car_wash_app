import 'package:car_wash_app/Admin/Pages/booking_page/widgets/main_container.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/widgets/page_title.dart';
import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideBookingPage extends ConsumerWidget {
  static const String pageName = "/adminSideBookingPage";
  const AdminSideBookingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(bookingsIntialStateProvider.notifier).getAllInitialBookings();
    ref.read(bookingsIntialStateProvider.notifier).dateTimeForFilter =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return const SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Expanded(flex: 10, child: AdminSideBookingPageTitle()),
          Expanded(flex: 90, child: AdminSideMainContainer())
        ],
      ),
    ));
  }
}
