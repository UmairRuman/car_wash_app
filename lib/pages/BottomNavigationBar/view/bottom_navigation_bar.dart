import 'package:car_wash_app/pages/BottomNavigationBar/Controller/bottom_bar_controller.dart';
import 'package:car_wash_app/pages/BottomNavigationBar/Widget/bottom_bar_widget.dart';
import 'package:car_wash_app/pages/HomePage/View/homePage.dart';
import 'package:car_wash_app/pages/favourite_page/view/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyBottomNavigationBar extends ConsumerWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentIndex = ref.watch(bottomStateProvider);
    return Scaffold(
      bottomNavigationBar: const HomePageBottomNavigationBar(),
      body: Builder(
        builder: (context) {
          if (currentIndex == 0) {
            return const HomePage();
          } else if (currentIndex == 1) {
            return Container();
          } else if (currentIndex == 2) {
            return const FavouritePage();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
