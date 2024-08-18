import 'package:car_wash_app/Admin/Pages/category_page/Widget/category_list_widgets/admin_side_categories_list_view.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/home_page_texts.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/previous_work_images.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/previous_work_text.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/profile_info.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/top_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideCategoryPage extends ConsumerWidget {
  static const String pageName = "/adminSideCategoryPage";
  final String profilePic;
  final String userName;
  final String location;
  const AdminSideCategoryPage({
    required this.location,
    required this.profilePic,
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
                flex: 30,
                child: LayoutBuilder(
                    builder: (context, constraints) => Stack(children: [
                          const HomePageTopContainer(),
                          Positioned(
                              height: constraints.maxHeight * 0.28,
                              width: constraints.maxWidth * 0.28,
                              left: constraints.maxWidth / 7 -
                                  (constraints.maxWidth * 0.35) / 2,
                              top: constraints.maxHeight / 4,
                              child: AdminProfilePic(
                                userProfilePic: profilePic,
                              )),
                          Positioned(
                              height: constraints.maxHeight * 0.1,
                              width: constraints.maxWidth * 0.3,
                              left: constraints.maxWidth / 6,
                              top: constraints.maxHeight / 4,
                              child: AdminUserNameText(
                                userName: userName,
                              )),
                          Positioned(
                              height: constraints.maxHeight * 0.1,
                              width: constraints.maxWidth * 0.4,
                              left: constraints.maxWidth / 2.5 -
                                  (constraints.maxWidth * 0.4) / 2,
                              top: constraints.maxHeight / 2.5,
                              child: AdminHomePageUserLocation(
                                userLocation: location,
                              )),
                          Positioned(
                              height: constraints.maxHeight * 0.15,
                              width: constraints.maxWidth * 0.1,
                              right: constraints.maxWidth / 7 -
                                  (constraints.maxWidth * 0.15) / 2,
                              top: constraints.maxHeight / 2.5 -
                                  (constraints.maxHeight * 0.15) / 2,
                              child: const AdminNotificationIcon()),
                          Positioned(
                              height: constraints.maxHeight * 0.25,
                              width: constraints.maxWidth * 0.85,
                              left: constraints.maxWidth / 2 -
                                  (constraints.maxWidth * 0.85) / 2,
                              bottom: constraints.maxHeight / 7 -
                                  (constraints.maxHeight * 0.2) / 2,
                              child: const AdminHomePageSearchBar()),
                        ]))),
            const Spacer(
              flex: 2,
            ),
            const Expanded(flex: 7, child: AdminHomePageServiceText()),
            const Spacer(
              flex: 2,
            ),
            const Expanded(flex: 20, child: AdminSideCategoriesList()),
            const Expanded(flex: 10, child: AdminHomePagePreviousServiceText()),
            const Expanded(flex: 26, child: AdminPreviousWorkImages()),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
