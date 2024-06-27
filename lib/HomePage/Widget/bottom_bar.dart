import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePageBottomNavigationBar extends StatefulWidget {
  const HomePageBottomNavigationBar({super.key});

  @override
  State<HomePageBottomNavigationBar> createState() =>
      _HomePageBottomNavigationBarState();
}

class _HomePageBottomNavigationBarState
    extends State<HomePageBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedNotchBottomBar(
      removeMargins: true,
      bottomBarWidth: MediaQuery.of(context).size.width,
      bottomBarHeight: screenHeight * 0.1,
      notchBottomBarController: NotchBottomBarController(),
      bottomBarItems: const <BottomBarItem>[
        //Home page Icon
        BottomBarItem(
          inActiveItem: Icon(
            Icons.home_outlined,
            color: Colors.blueGrey,
          ),
          activeItem: Icon(
            Icons.home,
            color: Colors.blueAccent,
          ),
          itemLabel: 'Home',
        ),
        //Booking  Icon
        BottomBarItem(
          inActiveItem: Icon(
            Icons.menu_book_rounded,
            color: Colors.blueGrey,
          ),
          activeItem: Icon(
            Icons.menu_book_sharp,
            color: Colors.blueAccent,
          ),
          itemLabel: 'Booking',
        ),
        //Favourite Icon
        BottomBarItem(
          inActiveItem: Icon(
            Icons.favorite_outline,
            color: Colors.blueGrey,
          ),
          activeItem: Icon(
            Icons.favorite,
            color: Colors.blueAccent,
          ),
          itemLabel: 'Favourite',
        ),
        //
        BottomBarItem(
          inActiveItem: Icon(
            Icons.person_2_outlined,
            color: Colors.blueGrey,
          ),
          activeItem: Icon(
            Icons.person_2_rounded,
            color: Colors.blueAccent,
          ),
          itemLabel: 'Profile',
        ),
      ],
      onTap: (value) {
        log(value.toString());
      },
      kBottomRadius: 0,
      kIconSize: screenWidth * 0.06,
    );
  }
}
