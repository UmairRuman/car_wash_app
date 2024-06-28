import 'package:car_wash_app/pages/favourite_page/widgets/favourite_service_list.dart';
import 'package:car_wash_app/pages/favourite_page/widgets/text.dart';
import 'package:car_wash_app/pages/favourite_page/widgets/user_info.dart';
import 'package:car_wash_app/utils/decorations/favourite_page_decorations.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            const Expanded(flex: 8, child: FavouritePageUserInfo()),
            Expanded(
                flex: 90,
                child: Container(
                  decoration: favouritePageContainerDecoration,
                  child: const Column(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(flex: 5, child: FavouritePageTitle()),
                      const Spacer(
                        flex: 3,
                      ),
                      Expanded(flex: 93, child: FavouriteServiceList())
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
