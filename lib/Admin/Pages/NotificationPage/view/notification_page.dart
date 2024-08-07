import 'package:car_wash_app/Admin/Pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/Admin/Pages/NotificationPage/widget/messsage_intial_widget.dart';
import 'package:car_wash_app/Admin/Pages/booking_page/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideNotificationPage extends ConsumerWidget {
  static const String pageName = "/AdminSideNotificationPage";
  const AdminSideNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listOfIntialMessages =
        ref.read(messageStateProvider.notifier).listOfIntialMessage;
    var state = ref.watch(messageStateProvider);
    return SafeArea(child: Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          if (state is MessageIntialState) {
            return MesssageIntialWidget(
                listOfIntialMessage: listOfIntialMessages);
          } else if (state is MessageLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is MessageLoadedState) {
            return ListView.builder(
              itemCount: state.listOfMessageModel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 30,
                            child: Text(
                              state.listOfMessageModel[index].messageTitle,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 50,
                            child: Text(
                              state.listOfMessageModel[index].messageBody,
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            )),
                        Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                const Spacer(
                                  flex: 60,
                                ),
                                Expanded(
                                    flex: 30,
                                    child: Text(state.listOfMessageModel[index]
                                        .messageDeliveredDate)),
                                const Spacer(
                                  flex: 10,
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              },
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
