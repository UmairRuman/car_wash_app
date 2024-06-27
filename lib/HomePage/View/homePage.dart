import 'package:car_wash_app/HomePage/Widget/bottom_bar.dart';
import 'package:car_wash_app/HomePage/Widget/categories_list_view.dart';
import 'package:car_wash_app/HomePage/Widget/home_page_texts.dart';
import 'package:car_wash_app/HomePage/Widget/previous_work_images.dart';
import 'package:car_wash_app/HomePage/Widget/previous_work_text.dart';
import 'package:car_wash_app/HomePage/Widget/profile_info.dart';
import 'package:car_wash_app/HomePage/Widget/top_container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomePageBottomNavigationBar(),
      body: Column(
        children: [
          Expanded(
              flex: 30,
              child: LayoutBuilder(
                  builder: (context, constraints) => Stack(children: [
                        const HomePageTopContainer(),
                        Positioned(
                            height: constraints.maxHeight * 0.25,
                            width: constraints.maxWidth * 0.25,
                            left: constraints.maxWidth / 7 -
                                (constraints.maxWidth * 0.3) / 2,
                            top: constraints.maxHeight / 4,
                            child: const ProfilePic()),
                        Positioned(
                            height: constraints.maxHeight * 0.1,
                            width: constraints.maxWidth * 0.3,
                            left: constraints.maxWidth / 6,
                            top: constraints.maxHeight / 4,
                            child: const UserNameText()),
                        Positioned(
                            height: constraints.maxHeight * 0.1,
                            width: constraints.maxWidth * 0.4,
                            left: constraints.maxWidth / 2.5 -
                                (constraints.maxWidth * 0.4) / 2,
                            top: constraints.maxHeight / 2.5,
                            child: const UserLocation()),
                        Positioned(
                            height: constraints.maxHeight * 0.15,
                            width: constraints.maxWidth * 0.1,
                            right: constraints.maxWidth / 7 -
                                (constraints.maxWidth * 0.15) / 2,
                            top: constraints.maxHeight / 2.5 -
                                (constraints.maxHeight * 0.15) / 2,
                            child: const NotificationIcon()),
                        Positioned(
                            height: constraints.maxHeight * 0.25,
                            width: constraints.maxWidth * 0.8,
                            left: constraints.maxWidth / 2 -
                                (constraints.maxWidth * 0.8) / 2,
                            bottom: constraints.maxHeight / 7 -
                                (constraints.maxHeight * 0.2) / 2,
                            child: const HomePageSearchBar()),
                      ]))),
          const Spacer(
            flex: 5,
          ),
          const Expanded(flex: 5, child: HomePageServiceText()),
          const Expanded(flex: 25, child: CategoriesList()),
          const Expanded(flex: 10, child: HomePagePreviousServiceText()),
          const Expanded(flex: 25, child: PreviousWorkImages()),
        ],
      ),
    );
  }
}
