import 'package:car_wash_app/Client/pages/NotificationPage/model/notification_model.dart';
import 'package:flutter/material.dart';

class MesssageIntialWidget extends StatelessWidget {
  final List<NotificationModel> listOfIntialMessage;
  const MesssageIntialWidget({super.key, required this.listOfIntialMessage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: listOfIntialMessage.length,
        itemBuilder: (context, index) {
          DateTime dateTime = listOfIntialMessage[index].carWashDate;
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
                    flex: 5,
                  ),
                  Expanded(
                      flex: 15,
                      child: Row(
                        children: [
                          const Spacer(
                            flex: 5,
                          ),
                          Expanded(
                            flex: 30,
                            child: FittedBox(
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      const TextSpan(
                                        text: "Mr.",
                                      ),
                                      TextSpan(
                                          text: listOfIntialMessage[index]
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
                  Expanded(
                      flex: 30,
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
                                  text: listOfIntialMessage[index].serviceName,
                                  style: const TextStyle(color: Colors.amber))
                            ]),
                      )),
                  Expanded(
                      flex: 40,
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: listOfIntialMessage[index].timeSlot,
                                  style: const TextStyle(color: Colors.red)),
                              const TextSpan(
                                  text: " slot has reserved for you on Date "),
                              TextSpan(
                                  text: carWashDate,
                                  style: const TextStyle(color: Colors.blue)),
                            ]),
                      )),
                  const Spacer(
                    flex: 5,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
