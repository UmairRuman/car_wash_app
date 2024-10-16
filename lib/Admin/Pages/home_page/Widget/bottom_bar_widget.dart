import 'package:car_wash_app/Admin/Pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideHomePageBottomNavigationBar extends ConsumerWidget {
  const AdminSideHomePageBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(bottomStateProvider);

    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Color.fromARGB(255, 37, 90, 134)),
      currentIndex: state,
      type: BottomNavigationBarType.fixed,

      backgroundColor: const Color.fromARGB(255, 237, 240, 243),
      // height: 55,

      // removeMargins: true,
      // bottomBarWidth: MediaQuery.of(context).size.width,
      // bottomBarHeight: screenHeight * 0.1,
      // notchBottomBarController: NotchBottomBarController(),
      // items:
      // const <Widget>[
      //   //Home page Icon
      //   Icon(
      //     Icons.home,
      //     color: Colors.blueAccent,
      //   ),
      //   //Booking  Icon
      //   Icon(
      //     Icons.menu_book_sharp,
      //     color: Colors.blueAccent,
      //   ),

      //   Icon(
      //     Icons.person_2_rounded,
      //     color: Colors.blueAccent,
      //   ),
      // ],
      onTap: (value) {
        ref.read(bottomStateProvider.notifier).currentNavigationState(value);
      },
      items: const [
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 37, 90, 134),
            ),
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.menu_book_sharp,
              color: Color.fromARGB(255, 37, 90, 134),
            ),
            icon: Icon(
              Icons.menu_book_sharp,
              color: Colors.blue,
            ),
            label: "Booking"),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person_2_rounded,
              color: Color.fromARGB(255, 37, 90, 134),
            ),
            icon: Icon(
              Icons.person_2_rounded,
              color: Colors.blue,
            ),
            label: "Profile")
      ],
    );
  }
}
