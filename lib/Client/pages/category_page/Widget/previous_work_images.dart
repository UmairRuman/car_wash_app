import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Client/pages/category_page/Widget/intial_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class PreviousWorkImages extends ConsumerWidget {
  const PreviousWorkImages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(previousServiceStateProvider);
    var intialList = ref.read(previousServiceStateProvider.notifier).intialList;
    return Builder(builder: (context) {
      if (state is PreviousDataInitialState) {
        return PreviousWorkIntialList(
          intialList: intialList,
        );
      } else if (state is PreviousDataLoadingState) {
        return const CircularProgressIndicator();
      } else if (state is PreviousDataLoadedState) {
        return LayoutBuilder(
          builder: (context, constraints) => AnimationLimiter(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                DateTime date = state.list[index].serviceProvideTime;
                String currentDate = "${date.day}-${date.month}-${date.year}";
                String formattedDate = convertDateFormat(currentDate);
                return AnimationConfiguration.staggeredList(
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
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: state.list[index].isAssetImage
                                        ? Image.asset(
                                            state.list[index].previousWorkImage,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: state
                                                .list[index].previousWorkImage,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  flex: 25,
                                  child: Row(children: [
                                    const Spacer(
                                      flex: 5,
                                    ),
                                    Expanded(
                                        flex: 45,
                                        child: AutoSizeText(
                                          state.list[index].serviceName,
                                          style: const TextStyle(fontSize: 16),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    const Spacer(
                                      flex: 10,
                                    ),
                                    Expanded(
                                        flex: 40,
                                        child: FittedBox(
                                          child: Text(
                                            formattedDate,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.blue),
                                          ),
                                        )),
                                    const Spacer(
                                      flex: 5,
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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

String convertDateFormat(String date) {
  // Parse the date string to a DateTime object
  DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);

  // Format the DateTime object to the desired format
  String formattedDate = DateFormat('dMMMM').format(parsedDate) +
      DateFormat('yy').format(parsedDate);

  return formattedDate;
}
