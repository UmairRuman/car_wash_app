import 'package:car_wash_app/Client/pages/booking_page/widgets/booking_page_title.dart';
import 'package:car_wash_app/Client/pages/booking_page/widgets/main_container.dart';
import 'package:car_wash_app/isolate_manager/booking_del_isolate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  static const String pageName = "/bookingPage";
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  BookingCleanupIsolateManager bookingCleanupIsolateManager =
      BookingCleanupIsolateManager.instance;
  @override
  void initState() {
    super.initState();
    bookingCleanupIsolateManager
        .startBookingCleanup(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Expanded(flex: 10, child: BookingPageTitle()),
          Expanded(flex: 90, child: MainContainer())
        ],
      ),
    ));
  }
}
