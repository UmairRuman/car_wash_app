import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Client/pages/booking_page/controller/intial_booking_controller.dart';
import 'package:car_wash_app/Client/pages/booking_page/view/booking_page.dart';
import 'package:car_wash_app/Client/pages/category_page/View/categoryPage.dart';
import 'package:car_wash_app/Client/pages/favourite_page/view/favourite_page.dart';
import 'package:car_wash_app/Client/pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:car_wash_app/Client/pages/home_page/Widget/bottom_bar_widget.dart';
import 'package:car_wash_app/Client/pages/profile_page/controller/profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/profile_page/view/profile_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/Controllers/favourite_service__state_controller.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends ConsumerWidget {
  static const String pageName = '/homePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializationState = ref.watch(initializationProvider);
    ref.read(bookingsIntialStateProvider.notifier).getAllInitialBookings();
    ref.read(favouriteServiceProvider.notifier).getAllIntialFavouriteServices();
    ref.read(profileDataStateProvider.notifier).getUserAllDData();
    ref
        .read(previousServiceStateProvider.notifier)
        .getIntialListPreviousServices();
    ref.read(allServiceDataStateProvider.notifier).getIntialListOfServices();
    // ref
    //     .read(previousServiceStateProvider.notifier)
    //     .addDefaultPreviousWorkCategories();
    // ref.read(defaultServicesStateProvider.notifier).addDefaultService();
    return initializationState.when(
      data: (_) {
        var state = ref.watch(userAdditionStateProvider);
        var currentIndex = ref.watch(bottomStateProvider);

        if (state is AddittionLoadedState) {
          return Scaffold(
              bottomNavigationBar: const HomePageBottomNavigationBar(),
              body: Builder(
                builder: (context) {
                  if (currentIndex == 0) {
                    return CategoryPage(
                        location: state.user.userLocation,
                        profilePic: state.user.profilePicUrl,
                        userName: state.user.name);
                  } else if (currentIndex == 1) {
                    return const BookingPage();
                  } else if (currentIndex == 2) {
                    return const FavouritePage();
                  } else {
                    return const ProfilePage();
                  }
                },
              ));
        } else if (state is AdditionErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        }
        return const Scaffold(
          backgroundColor: Colors.blue,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitThreeBounce(
                color: Colors.white,
                size: 60,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Fetching Services For You...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              )
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text("Initialization Error: $error"),
        ),
      ),
    );
  }
}
