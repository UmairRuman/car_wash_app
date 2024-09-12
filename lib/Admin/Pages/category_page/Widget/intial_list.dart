import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Controller/previous_service_addition_controller.dart';
import 'package:car_wash_app/ModelClasses/previous_work_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class AdminSideIntialListPreviousWork extends ConsumerStatefulWidget {
  final List<PreviousWorkModel> intialList;
  const AdminSideIntialListPreviousWork({super.key, required this.intialList});

  @override
  ConsumerState<AdminSideIntialListPreviousWork> createState() =>
      _IntialListPreviousWorkState();
}

class _IntialListPreviousWorkState
    extends ConsumerState<AdminSideIntialListPreviousWork> {
  late List<FlipCardController> _controller;

  @override
  void initState() {
    super.initState();
    initializeControllers();
  }

  void initializeControllers() {
    _controller =
        List.generate(widget.intialList.length, (_) => FlipCardController());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => AnimationLimiter(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.intialList.length,
          itemBuilder: (context, index) {
            DateTime date = widget.intialList[index].serviceProvideTime;
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
                    child: FlipCard(
                      controller: _controller[index],
                      direction: FlipDirection.VERTICAL,
                      // Back Side
                      back: InkWell(
                        onLongPress: () {
                          log("Tap on Back Side");
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
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              //Delete previous Work
                              ref
                                  .read(previousServiceStateProvider.notifier)
                                  .deleteSpecificPreviousData(
                                      widget.intialList[index].id);
                              //Also deleting image from firesbase storage
                              FirebaseStorage.instance
                                  .ref()
                                  .child("Images")
                                  .child(FirebaseAuth.instance.currentUser!.uid)
                                  .child("previousWorkImages")
                                  .child(widget.intialList[index].serviceName)
                                  .delete();
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      // Front Side
                      front: SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth / 2,
                        child: InkWell(
                          onLongPress: () {
                            log("Clicked on Front Side ");
                            _controller[index].toggleCard();
                          },
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
                                      topRight: Radius.circular(20),
                                    ),
                                    child: widget.intialList[index].isAssetImage
                                        ? Image.asset(
                                            widget.intialList[index]
                                                .previousWorkImage,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: widget.intialList[index]
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
                                  child: Row(
                                    children: [
                                      const Spacer(flex: 3),
                                      Expanded(
                                        flex: 44,
                                        child: AutoSizeText(
                                          widget.intialList[index].serviceName,
                                          style: const TextStyle(fontSize: 16),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(flex: 8),
                                      Expanded(
                                        flex: 42,
                                        child: AutoSizeText(
                                          formattedDate,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 14),
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 3,
                                      )
                                    ],
                                  ),
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
            );
          },
        ),
      ),
    );
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
