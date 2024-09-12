import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_name_controller.dart';
import 'package:car_wash_app/Controllers/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditRatingVariables {
  static double currentRating = 1;
  static bool isClickOnSave = false;
}

void dialogForRating(
    BuildContext context, WidgetRef ref, String serviceName, String serviceId) {
  var finalRating = ref.read(ratingStateProvider.notifier).finalRating;
  var isServiceRated = ref.read(ratingStateProvider.notifier).isServiceRated;
  EditRatingVariables.currentRating = finalRating;
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) => Container(
              height: MediaQuery.of(context).size.height / 4.5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Consumer(
                  builder: (context, ref, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 10,
                      ),
                      Expanded(
                        flex: 40,
                        child: Center(
                          child: RatingBar.builder(
                            initialRating: finalRating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (rating) {
                              setState(() {
                                setState(() {
                                  EditRatingVariables.currentRating = rating;
                                });
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 20,
                          child: Row(
                            children: [
                              const Spacer(
                                flex: 35,
                              ),
                              Expanded(
                                  flex: 30,
                                  child: FittedBox(
                                      child: Text(
                                    EditRatingVariables.isClickOnSave
                                        ? finalRating.toString()
                                        : EditRatingVariables.currentRating
                                            .toString(),
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ))),
                              const Spacer(
                                flex: 35,
                              )
                            ],
                          )),
                      Expanded(
                        flex: 30,
                        child: Row(
                          children: [
                            const Spacer(
                              flex: 6,
                            ),
                            Expanded(
                              flex: 40,
                              child: FloatingActionButton(
                                onPressed: () {
                                  EditRatingVariables.currentRating = 1;
                                  ref
                                      .read(serviceNameProvider.notifier)
                                      .disposeController();
                                  Navigator.of(context).pop();
                                },
                                backgroundColor: const Color(0xFF1BC0C5),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 8,
                            ),
                            Expanded(
                              flex: 40,
                              child: FloatingActionButton(
                                onPressed: () {
//Setting User selected rating and bool so that i will come to know that whether userRated or not
                                  EditRatingVariables.isClickOnSave = true;

                                  ref
                                      .read(ratingStateProvider.notifier)
                                      .addRatingFromUser(
                                          serviceId,
                                          serviceName,
                                          EditRatingVariables.currentRating,
                                          isServiceRated);

                                  Navigator.of(context).pop();
                                },
                                backgroundColor: const Color(0xFF1BC0C5),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 6,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
