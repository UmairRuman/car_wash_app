import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/incrementing_days_controller.dart';
import 'package:car_wash_app/Dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

class IncrementingDaysConstants {
  static const minDays = 1;
  static const maxDays = 31;
}

void dialogForIncreametingDates(BuildContext context, String serviceId,
    String serviceName, bool isFavourite) {
  showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) => Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    var intialShowingDates = ref
                        .read(increamentingDaysStateProvider.notifier)
                        .intialShowingDates;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                Spacer(
                                  flex: 15,
                                ),
                                Expanded(
                                    flex: 70,
                                    child: FittedBox(
                                      child: Text(
                                        "Choose No of Days to show",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Spacer(
                                  flex: 15,
                                )
                              ],
                            )),
                        Expanded(
                            flex: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 75,
                                      child: NumberPicker(
                                        value: intialShowingDates,
                                        minValue:
                                            IncrementingDaysConstants.minDays,
                                        maxValue:
                                            IncrementingDaysConstants.maxDays,
                                        onChanged: (value) => setState(() {
                                          ref
                                              .read(
                                                  increamentingDaysStateProvider
                                                      .notifier)
                                              .intialShowingDates = value;
                                          intialShowingDates = value;
                                        }),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                              child: Text(
                                                  'Days: $intialShowingDates')),
                                        )),
                                  ],
                                ),
                              ],
                            )),
                        Expanded(
                          flex: 20,
                          child: Row(
                            children: [
                              const Spacer(
                                flex: 6,
                              ),
                              Expanded(
                                flex: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.blue,
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
                                child: MaterialButton(
                                  onPressed: () async {
                                    informerDialog(context, "Updating Dates");
                                    await ref
                                        .read(increamentingDaysStateProvider
                                            .notifier)
                                        .onUpdateBtnClickToIncreamentDays(
                                            serviceId,
                                            serviceName,
                                            isFavourite);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.blue,
                                  child: const Text(
                                    "Update",
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      });
}
