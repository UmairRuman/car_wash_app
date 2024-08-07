import 'package:car_wash_app/Admin/Pages/booking_page/model/message_model.dart';
import 'package:flutter/material.dart';

class MesssageIntialWidget extends StatelessWidget {
  final List<MessageModel> listOfIntialMessage;
  const MesssageIntialWidget({super.key, required this.listOfIntialMessage});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfIntialMessage.length,
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
                      listOfIntialMessage[index].messageTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 50,
                    child: Text(
                      listOfIntialMessage[index].messageBody,
                      style: const TextStyle(fontStyle: FontStyle.italic),
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
                            child: Text(listOfIntialMessage[index]
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
  }
}
