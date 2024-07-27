import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/ModelClasses/previous_work_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class IntialListPreviousWork extends StatelessWidget {
  final List<PreviousWorkModel> intialList;
  const IntialListPreviousWork({super.key, required this.intialList});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => AnimationLimiter(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: intialList.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
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
                              child: intialList[index].isAssetImage
                                  ? Image.asset(
                                      intialList[index].previousWorkImage,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          intialList[index].previousWorkImage,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
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
                                  flex: 50,
                                  child: FittedBox(
                                      child:
                                          Text(intialList[index].serviceName))),
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
                                        child: Text(intialList[index]
                                            .serviceRating
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
  }
}
