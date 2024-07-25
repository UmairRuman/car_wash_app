import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/intial_list.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdminPreviousWorkImages extends ConsumerWidget {
  const AdminPreviousWorkImages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(previousServiceStateProvider);
    var intialList = ref.read(previousServiceStateProvider.notifier).intialList;
    return Builder(builder: (context) {
      if (state is PreviousDataInitialState) {
        return IntialListPreviousWork(
          intialList: intialList,
        );
      } else if (state is PreviousDataLoadingState) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (state is PreviousDataLoadedState) {
        return LayoutBuilder(
          builder: (context, constraints) => AnimationLimiter(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.list.length,
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                duration: const Duration(seconds: 1),
                position: index,
                child: SlideAnimation(
                  verticalOffset: -50,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth / 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 75,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                state.list[index].isAssetImage
                                                    ? AssetImage(state
                                                        .list[index]
                                                        .previousWorkImage)
                                                    : NetworkImage(state
                                                        .list[index]
                                                        .previousWorkImage)))),
                              ),
                              Expanded(
                                flex: 25,
                                child: Row(children: [
                                  const Spacer(
                                    flex: 5,
                                  ),
                                  Expanded(
                                      flex: 50,
                                      child: FittedBox(
                                          child: Text(
                                              state.list[index].serviceName))),
                                  const Spacer(
                                    flex: 5,
                                  ),
                                  Expanded(
                                      flex: 40,
                                      child: Row(
                                        children: [
                                          const Spacer(
                                            flex: 20,
                                          ),
                                          Expanded(
                                            flex: 30,
                                            child: Text(state
                                                .list[index].serviceRating
                                                .toString()),
                                          ),
                                          const Expanded(
                                            flex: 30,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          const Spacer(
                                            flex: 20,
                                          ),
                                        ],
                                      ))
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        String error = (state as PreviousDataErrorState).error;
        return Scaffold(
          body: Center(
            child: Text(error),
          ),
        );
      }
    });
  }
}
