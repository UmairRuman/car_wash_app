import 'package:car_wash_app/Admin/Pages/booking_page/widgets/main_container.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/widgets/page_title.dart';
import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/isolate_manager/booking_del_isolate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideBookingPage extends ConsumerStatefulWidget {
  static const String pageName = "/adminSideBookingPage";
  const AdminSideBookingPage({super.key});

  @override
  ConsumerState<AdminSideBookingPage> createState() =>
      _AdminSideBookingPageState();
}

class _AdminSideBookingPageState extends ConsumerState<AdminSideBookingPage> {
  BookingCleanupIsolateManager bookingCleanupIsolateManager =
      BookingCleanupIsolateManager.instance;
  @override
  void initState() {
    super.initState();
    bookingCleanupIsolateManager
        .startBookingCleanup(FirebaseAuth.instance.currentUser!.uid);
    ref.read(bookingsIntialStateProvider.notifier).getAllInitialBookings();
  }

  @override
  Widget build(BuildContext context) {
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
