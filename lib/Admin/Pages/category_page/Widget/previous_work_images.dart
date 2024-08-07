import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/intial_list.dart';
import 'package:car_wash_app/ModelClasses/previous_work_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AdminPreviousWorkImages extends ConsumerStatefulWidget {
  const AdminPreviousWorkImages({super.key});

  @override
  ConsumerState<AdminPreviousWorkImages> createState() =>
      _AdminPreviousWorkImagesState();
}

class _AdminPreviousWorkImagesState
    extends ConsumerState<AdminPreviousWorkImages> {
  late List<FlipCardController> _controller;

  @override
  void initState() {
    super.initState();
    // secondController = FlipController();
  }

  void initializeControllers(List<PreviousWorkModel> list) {
    _controller = List.generate(list.length, (_) => FlipCardController());
  }

  @override
  void dispose() {
    // for (var controller in flipControllers) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        initializeControllers(state.list);

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
                      child: FlipCard(
                        controller: _controller[index],
                        direction: FlipDirection.VERTICAL,
                        //Back Side
                        back: InkWell(
                          onLongPress: () {
                            log("Clicked on Back Side ");
                            _controller[index].toggleCard();
                          },
                          child: Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth / 2,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 12, 136, 238),
                                      offset: Offset(3, 3),
                                      blurRadius: 3)
                                ]),
                            child: InkWell(
                              onTap: () {
                                //Delete previous Work
                                ref
                                    .read(previousServiceStateProvider.notifier)
                                    .deleteSpecificPreviousData(
                                        state.list[index].id);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                        //Front side
                        front: InkWell(
                          onLongPress: () {
                            log("Clicked on Front Side ");
                            _controller[index].toggleCard();
                          },
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
                                              state.list[index]
                                                  .previousWorkImage,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: state.list[index]
                                                  .previousWorkImage,
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
                                        flex: 40,
                                        child: AutoSizeText(
                                          state.list[index].serviceName,
                                          style: const TextStyle(fontSize: 16),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
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
