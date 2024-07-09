import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/year_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

class YearVariables {
  static int minValue = 2024;
  static int maxValue = 2050;
}

void dialogForEditYear(BuildContext context) {
  showDialog(
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
                    var currentYear =
                        ref.read(yearStateProvider.notifier).intialYear;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                Spacer(
                                  flex: 25,
                                ),
                                Expanded(
                                    flex: 50,
                                    child: FittedBox(
                                      child: Text(
                                        "Choose Year Of service",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Spacer(
                                  flex: 25,
                                )
                              ],
                            )),
                        Expanded(
                            flex: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 70,
                                      child: NumberPicker(
                                        value: currentYear,
                                        minValue: YearVariables.minValue,
                                        maxValue: YearVariables.maxValue,
                                        onChanged: (value) => setState(() {
                                          ref
                                              .read(yearStateProvider.notifier)
                                              .onChangeYear(value);
                                          currentYear = value;
                                        }),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 10,
                                    ),
                                    Expanded(
                                        flex: 20,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                              child:
                                                  Text('Year: $currentYear')),
                                        )),
                                  ],
                                ),
                              ],
                            )),
                        const Spacer(
                          flex: 15,
                        ),
                        Expanded(
                          flex: 20,
                          child: Row(
                            children: [
                              const Spacer(
                                flex: 6,
                              ),
                              Expanded(
                                flex: 40,
                                child: FloatingActionButton(
                                  onPressed: () {
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
                    );
                  },
                ),
              ),
            ),
          ),
        );
      });
}
