import 'package:car_wash_app/Admin/Pages/booking_page/widgets/main_container.dart';
import 'package:car_wash_app/Client/pages/booking_page/widgets/booking_page_title.dart';
import 'package:car_wash_app/Client/pages/booking_page/widgets/main_container.dart';
import 'package:flutter/material.dart';

class AdminSideBookingPage extends StatelessWidget {
  static const String pageName = "/adminSideBookingPage";
  const AdminSideBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Expanded(flex: 10, child: BookingPageTitle()),
          Expanded(flex: 90, child: AdminSideMainContainer())
        ],
      ),
    ));
  }
}
