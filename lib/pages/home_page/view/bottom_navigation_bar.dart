import 'package:car_wash_app/pages/booking_page/view/booking_page.dart';
import 'package:car_wash_app/pages/category_page/View/categoryPage.dart';
import 'package:car_wash_app/pages/favourite_page/view/favourite_page.dart';
import 'package:car_wash_app/pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:car_wash_app/pages/home_page/Widget/bottom_bar_widget.dart';
import 'package:car_wash_app/pages/profile_page/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  static const String pageName = '/homePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentIndex = ref.watch(bottomStateProvider);
    return Scaffold(
      bottomNavigationBar: const HomePageBottomNavigationBar(),
      body: Builder(
        builder: (context) {
          if (currentIndex == 0) {
            return const CategoryPage();
          } else if (currentIndex == 1) {
            return const BookingPage();
          } else if (currentIndex == 2) {
            return const FavouritePage();
          } else {
            return const ProfilePage();
          }
        },
      ),
    );
  }
}
