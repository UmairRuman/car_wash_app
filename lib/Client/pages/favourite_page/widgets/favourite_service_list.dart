import 'package:car_wash_app/Client/pages/favourite_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/favourite_page/widgets/container.dart';
import 'package:car_wash_app/Client/pages/favourite_page/widgets/user_info.dart';
import 'package:car_wash_app/Controllers/favourite_service__state_controller.dart';
import 'package:car_wash_app/utils/decorations/favourite_page_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavouriteServiceList extends ConsumerWidget {
  const FavouriteServiceList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(favouriteServiceProvider);
    var listOfFavouriteServices =
        ref.read(favouriteServiceProvider.notifier).listOfFavouriteServices;
    if (state is FavouriteServiceIntialState) {
      return LayoutBuilder(
        builder: (context, constraints) => ListView.builder(
          itemCount: listOfFavouriteServices.length,
          itemBuilder: (context, index) {
            var serviceName = listOfFavouriteServices[index].serviceName;
            var serviceRating = listOfFavouriteServices[index].serviceRating;
            var servicePrice = listOfFavouriteServices[index].servicePrice;
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 10),
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 5,
                decoration: favouriteCategoryContainerDecoration,
                child: Row(
                  children: [
                    Expanded(
                        flex: 40,
                        child: FavouriteCategoryPic(
                            favouriteCategoryimagePath:
                                listOfFavouriteServices[index]
                                    .serviceImageUrl)),
                    Expanded(
                        flex: 30,
                        child: FavouriteCategoryContainerInfo(
                            rating: serviceRating,
                            carWashCategoryPrice: servicePrice,
                            carWashCategoryName: serviceName)),
                    Expanded(
                        flex: 30,
                        child: InkWell(
                            child: FavouriteCategoryBookButton(
                          serviceId:
                              listOfFavouriteServices[index].favouriteServiceId,
                          serviceName:
                              listOfFavouriteServices[index].serviceName,
                        ))),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else if (state is FavouriteServiceLoadingState) {
      return const Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitPouringHourGlass(
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
                  fontSize: 22),
            )
          ],
        ),
      );
    } else if (state is FavouriteServiceLoadedState) {
      return LayoutBuilder(
        builder: (context, constraints) => ListView.builder(
          itemCount: state.listOfFavouriteServices.length,
          itemBuilder: (context, index) {
            var serviceName = state.listOfFavouriteServices[index].serviceName;
            var serviceRating =
                state.listOfFavouriteServices[index].serviceRating;
            var servicePrice =
                state.listOfFavouriteServices[index].servicePrice;
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 10),
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 5,
                decoration: favouriteCategoryContainerDecoration,
                child: Row(
                  children: [
                    Expanded(
                        flex: 40,
                        child: FavouriteCategoryPic(
                            favouriteCategoryimagePath: state
                                .listOfFavouriteServices[index]
                                .serviceImageUrl)),
                    Expanded(
                        flex: 30,
                        child: FavouriteCategoryContainerInfo(
                            rating: serviceRating,
                            carWashCategoryPrice: servicePrice,
                            carWashCategoryName: serviceName)),
                    Expanded(
                        flex: 30,
                        child: FavouriteCategoryBookButton(
                          serviceId: state.listOfFavouriteServices[index]
                              .favouriteServiceId,
                          serviceName: serviceName,
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      var error = (state as FavouriteServiceErrorState).error;
      return Scaffold(
        body: Center(
          child: Text(
            error,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
    }
  }
}
