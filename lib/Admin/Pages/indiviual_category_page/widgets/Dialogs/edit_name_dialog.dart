import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/dialogs_controller.dart/service_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? imageFilePath;
bool isClickedOnCamera = false;
void dialogOnEditNameClick(BuildContext context) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: StatefulBuilder(
            builder: (context, setState) => Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Consumer(
                  builder: (context, ref, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 50,
                        child: TextField(
                          controller: ref
                              .read(serviceNameProvider.notifier)
                              .serviceNameTEC,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              hintText: 'Service Name'),
                        ),
                      ),
                      Expanded(
                        flex: 45,
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
                                  var nameTEC = ref
                                      .read(serviceNameProvider.notifier)
                                      .serviceNameTEC;
                                  ref
                                      .watch(serviceNameProvider.notifier)
                                      .onchangeTitle(nameTEC.text);
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
