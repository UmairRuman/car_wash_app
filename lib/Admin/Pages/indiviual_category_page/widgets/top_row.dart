import 'package:car_wash_app/Controllers/rating_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideTopRowIndiviualCategoryPage extends ConsumerWidget {
  final String serviceName;
  const AdminSideTopRowIndiviualCategoryPage(
      {super.key, required this.serviceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(ratingStateProvider);
    var intialListOfRatings =
        ref.read(ratingStateProvider.notifier).listOfRatings;
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        Expanded(
            flex: 10,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back_ios))),
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 30,
            child: FittedBox(
                child: Text(
              serviceName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 103, 167)),
            ))),
        const Spacer(
          flex: 15,
        ),
        Expanded(
          flex: 15,
          child: Builder(
            builder: (context) {
              if (state is RatingFetchingIntialState) {
                double ratingSum = 0;
                for (var index = 0;
                    index < intialListOfRatings.length;
                    index++) {
                  ratingSum += intialListOfRatings[index].rating;
                }
                double totalRating = ratingSum / intialListOfRatings.length;
                return intialListOfRatings.isEmpty
                    ? const FittedBox(child: Text("No Rating Till"))
                    : Row(
                        children: [
                          Expanded(
                              flex: 50,
                              child: Text(
                                totalRating.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          const Expanded(
                              flex: 15,
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )),
                          const Spacer(
                            flex: 35,
                          )
                        ],
                      );
              } else if (state is RatingFetchingLoadingState) {
                return const Scaffold(
                  body: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else if (state is RatingFetchingLoadedState) {
                double ratingSum = 0;
                for (var index = 0;
                    index < state.listOfRatings.length;
                    index++) {
                  ratingSum += state.listOfRatings[index].rating;
                }
                double totalRating = ratingSum / state.listOfRatings.length;
                return state.listOfRatings.isEmpty
                    ? const FittedBox(child: Text("No Rating till"))
                    : Row(
                        children: [
                          Expanded(
                              flex: 50,
                              child: Text(
                                totalRating.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          const Expanded(
                              flex: 15,
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )),
                          const Spacer(
                            flex: 35,
                          )
                        ],
                      );
              } else {
                return Scaffold(
                  body: Center(
                    child: Text((state as RatingFetchingErrorState).error),
                  ),
                );
              }
            },
          ),
        ),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
