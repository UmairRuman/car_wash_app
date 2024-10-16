import 'dart:developer';

import 'package:car_wash_app/Admin/Pages/booking_page/view/booking_page.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/View/admin_side_categoryPage.dart';
import 'package:car_wash_app/Admin/Pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:car_wash_app/Admin/Pages/home_page/Widget/bottom_bar_widget.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/view/profile_page.dart';
import 'package:car_wash_app/Client/pages/ErrorPage/error_page.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Client/pages/profile_page/controller/profile_state_controller.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminSideHomePage extends ConsumerStatefulWidget {
  static const String pageName = '/adminSideHomePage';
  const AdminSideHomePage({super.key});

  @override
  ConsumerState<AdminSideHomePage> createState() => _AdminSideHomePageState();
}

class _AdminSideHomePageState extends ConsumerState<AdminSideHomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(profileDataStateProvider.notifier).getUserAllDData();
    ref
        .read(previousServiceStateProvider.notifier)
        .getIntialListPreviousServices();
    ref.read(allServiceDataStateProvider.notifier).getIntialListOfServices();

    ref.read(messageStateProvider.notifier).intialMessages();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(userAdditionStateProvider.notifier).getUser();
    });
  }

  // void delayingFunctionExecution() async {
  //   await Future.delayed(const Duration(seconds: 3));
  // }

  @override
  Widget build(BuildContext context) {
    log("Home Page Rebuild");

    var currentIndex = ref.watch(bottomStateProvider);
    var state = ref.watch(userAdditionStateProvider);
    return switch (state) {
      AdditionIntialState() => const Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: Colors.white,
                  size: 60,
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
          ),
        ),
      AdditionLoadingState() => const Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: Colors.white,
                  size: 60,
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
          ),
        ),
      AddittionLoadedState() => Scaffold(
          bottomNavigationBar: const AdminSideHomePageBottomNavigationBar(),
          body: switch (currentIndex) {
            0 => AdminSideCategoryPage(
                location: state.user.userLocation,
                profilePic: state.user.profilePicUrl,
                userName: state.user.name),
            1 => const AdminSideBookingPage(),
            2 => const AdminSideProfilePage(),
            _ => const SizedBox.shrink()
          }),
      AdditionErrorState() => const ErrorPage(),
    };
  }
}

//     return initializationState.when(
//       data: (_) {
//         var state = ref.watch(userAdditionStateProvider);

//         if (state is AddittionLoadedState) {
//           log("User location ${state.user.userLocation}");
//           log("Profile pic ${state.user.profilePicUrl}");
//           log("User name ${state.user.name}");

//           log("Admmin Home Current Navigation state = $currentIndex");
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             bottomNavigationBar: const AdminSideHomePageBottomNavigationBar(),
//             body: currentIndex == 0
//                 ? AdminSideCategoryPage(
//                     location: state.user.userLocation,
//                     profilePic: state.user.profilePicUrl,
//                     userName: state.user.name,
//                   )
//                 : currentIndex == 1
//                     ? const AdminSideBookingPage()
//                     : const AdminSideProfilePage(),
//           );
//         } else if (state is AdditionErrorState) {
//           return Scaffold(
//             body: Center(
//               child: Text(state.error),
//             ),
//           );
//         }
//         return const Scaffold(
//           backgroundColor: Colors.blue,
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SpinKitThreeBounce(
//                 color: Colors.white,
//                 size: 60,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Fetching Services For You...",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 25),
//               )
//             ],
//           ),
//         );
//       },
//       loading: () => const Scaffold(
//         backgroundColor: Colors.blue,
//         body: Center(
//           child: SpinKitThreeBounce(
//             color: Colors.white,
//             size: 60,
//           ),
//         ),
//       ),
//       error: (error, stack) => Scaffold(
//         body: Center(
//           child: Text("Initialization Error: $error"),
//         ),
//       ),
//     );
//   }
// }
