import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/widget/messsage_intial_widget.dart';
import 'package:car_wash_app/isolate_manager/notification_del_isolate.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationPage extends ConsumerStatefulWidget {
  static const String pageName = "/NotificationPage";
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  NotificationCleanupIsolateManager notificationCleanupIsolateManager =
      NotificationCleanupIsolateManager.instance;
  @override
  void initState() {
    super.initState();
    notificationCleanupIsolateManager
        .startNotificationCleanup(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    var listOfIntialMessages =
        ref.read(messageStateProvider.notifier).listOfIntialMessage;
    var state = ref.watch(messageStateProvider);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Row(
          children: [
            const Expanded(
              flex: 80,
              child: FittedBox(
                child: Text(
                  "Notification Page",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(flex: 20, child: Image.asset(notificationPageImage))
          ],
        ),
      ),
      body: Center(
        child: Builder(builder: (context) {
          if (state is MessageIntialState) {
            return MesssageIntialWidget(
                listOfIntialMessage: listOfIntialMessages);
          } else if (state is MessageLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is MessageLoadedState) {
            return LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                itemCount: state.listOfMessageModel.length,
                itemBuilder: (context, index) {
                  var date =
                      state.listOfMessageModel[index].notificationDeliveredDate;
                  String notificationDeleiveredData =
                      "${date.day}-${date.month}-${date.year}";
                  DateTime dateTime =
                      state.listOfMessageModel[index].carWashDate;
                  String carWashDate =
                      "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: const Color.fromARGB(255, 156, 199, 235),
                                offset: Offset(5, 5),
                                blurRadius: 5)
                          ]),
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 3,
                          ),
                          Expanded(
                              flex: 15,
                              child: Row(
                                children: [
                                  const Spacer(
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 33,
                                    child: FittedBox(
                                      child: RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                              const TextSpan(
                                                text: "Hi,",
                                              ),
                                              TextSpan(
                                                  text: state
                                                      .listOfMessageModel[index]
                                                      .bookerName,
                                                  style: const TextStyle(
                                                      color: Colors.orange)),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 65,
                                  ),
                                ],
                              )),
                          const Spacer(
                            flex: 3,
                          ),
                          Expanded(
                              flex: 38,
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(
                                          text:
                                              "You have successfully booked service "),
                                      TextSpan(
                                          text:
                                              "${state.listOfMessageModel[index].serviceName}.",
                                          style: const TextStyle(
                                              color: Colors.amber))
                                    ]),
                              )),
                          Expanded(
                              flex: 30,
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: state.listOfMessageModel[index]
                                              .timeSlot,
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      const TextSpan(
                                          text:
                                              " slot has reserved for you on Date "),
                                      TextSpan(
                                          text: "$carWashDate.",
                                          style: const TextStyle(
                                              color: Colors.blue)),
                                    ]),
                              )),
                          const Spacer(
                            flex: 3,
                          ),
                          Expanded(
                              flex: 10,
                              child: Row(
                                children: [
                                  const Spacer(
                                    flex: 60,
                                  ),
                                  Expanded(
                                      flex: 40,
                                      child: FittedBox(
                                          child: Text(
                                              notificationDeleiveredData))),
                                ],
                              )),
                          const Spacer(
                            flex: 3,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            String error = (state as MessageErrorState).error;
            return Text(error);
          }
        }),
      ),
    ));
  }
}
