import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/category_page/Controller/default_services_controller.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/categories_list_view.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/home_page_texts.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/previous_work_images.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/previous_work_text.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/profile_info.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/top_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryPage extends ConsumerWidget {
  static const String pageName = "/categoryPage";
  final String profilePic;
  final String userName;
  final String location;
  const CategoryPage(
      {super.key,
      required this.location,
      required this.profilePic,
      required this.userName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return Column(
            children: [
              Expanded(
                  flex: 30,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Stack(children: [
                      const HomePageTopContainer(),
                      Positioned(
                          height: constraints.maxHeight * 0.25,
                          width: constraints.maxWidth * 0.25,
                          left: constraints.maxWidth / 7 -
                              (constraints.maxWidth * 0.3) / 2,
                          top: constraints.maxHeight / 4,
                          child: ProfilePic(
                            userProfilePic: profilePic,
                          )),
                      Positioned(
                          height: constraints.maxHeight * 0.1,
                          width: constraints.maxWidth * 0.3,
                          left: constraints.maxWidth / 6,
                          top: constraints.maxHeight / 4,
                          child: UserNameText(
                            userName: userName,
                          )),
                      Positioned(
                          height: constraints.maxHeight * 0.1,
                          width: constraints.maxWidth * 0.4,
                          left: constraints.maxWidth / 2.5 -
                              (constraints.maxWidth * 0.4) / 2,
                          top: constraints.maxHeight / 2.5,
                          child: HomePageUserLocation(
                            userLocation: location,
                          )),
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
                    ]);
                  })),
              const Spacer(
                flex: 3,
              ),
              const Expanded(flex: 5, child: HomePageServiceText()),
              const Spacer(
                flex: 3,
              ),
              const Expanded(flex: 22, child: CategoriesList()),
              const Expanded(flex: 10, child: HomePagePreviousServiceText()),
              const Expanded(flex: 27, child: PreviousWorkImages()),
            ],
          );
        }),
      ),
    );
  }
}
