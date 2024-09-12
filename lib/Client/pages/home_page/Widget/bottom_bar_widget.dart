import 'package:car_wash_app/Admin/Pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageBottomNavigationBar extends ConsumerWidget {
  const HomePageBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return CurvedNavigationBar(
      backgroundColor: const Color.fromARGB(255, 191, 214, 232),
      height: 65,

      // removeMargins: true,
      // bottomBarWidth: MediaQuery.of(context).size.width,
      // bottomBarHeight: screenHeight * 0.1,
      // notchBottomBarController: NotchBottomBarController(),
      items: const <Widget>[
        //Home page Icon
        Icon(
          Icons.home,
          color: Colors.blueAccent,
        ),
        //Booking  Icon
        Icon(
          Icons.menu_book_sharp,
          color: Colors.blueAccent,
        ),
        Icon(
          Icons.favorite,
          color: Colors.blueAccent,
        ),
        Icon(
          Icons.person_2_rounded,
          color: Colors.blueAccent,
        ),
      ],
      onTap: (value) {
        ref.read(bottomStateProvider.notifier).currentNavigationState(value);
      },
    );
  }
}
