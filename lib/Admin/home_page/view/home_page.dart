import 'package:car_wash_app/Admin/booking_page/view/booking_page.dart';
import 'package:car_wash_app/Admin/category_page/View/categoryPage.dart';
import 'package:car_wash_app/Admin/profile_page/view/profile_page.dart';
import 'package:car_wash_app/Client/pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:car_wash_app/Client/pages/home_page/Widget/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideHomePage extends ConsumerWidget {
  static const String pageName = '/adminSideHomePage';
  const AdminSideHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentIndex = ref.watch(bottomStateProvider);
    return Scaffold(
      bottomNavigationBar: const HomePageBottomNavigationBar(),
      body: Builder(
        builder: (context) {
          if (currentIndex == 0) {
            return const AdminSideCategoryPage();
          } else if (currentIndex == 1) {
            return const AdminSideBookingPage();
          } else {
            return const AdminSideProfilePage();
          }
        },
      ),
    );
  }
}
