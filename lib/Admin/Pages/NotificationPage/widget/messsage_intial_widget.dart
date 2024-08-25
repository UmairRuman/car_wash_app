import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/model/notification_model.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class AdminSideMesssageIntialWidget extends StatelessWidget {
  final List<NotificationModel> listOfIntialMessage;
  const AdminSideMesssageIntialWidget(
      {super.key, required this.listOfIntialMessage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: listOfIntialMessage.length,
        itemBuilder: (context, index) {
          var date = listOfIntialMessage[index].notificationDeliveredDate;
          String notificationDeleiveredData =
              "${date.day}-${date.month}-${date.year}";
          DateTime dateTime = listOfIntialMessage[index].carWashDate;
          String carWashDate =
              "${dateTime.day}-${dateTime.month}-${dateTime.year}";
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: constraints.maxHeight * 0.12,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 156, 199, 235),
                      offset: Offset(5, 5),
                      blurRadius: 5)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 25,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 70,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            listOfIntialMessage[index]
                                                .bookerPic),
                                        fit: BoxFit.fill)),
                                child: listOfIntialMessage[index].bookerPic ==
                                        ""
                                    ? Image.asset(emptyImage)
                                    : CachedNetworkImage(
                                        imageUrl: listOfIntialMessage[index]
                                            .bookerPic,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                              )),
                          const Spacer(
                            flex: 30,
                          )
                        ],
                      )),
                  Expanded(
                    flex: 75,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 3,
                          ),
                          Expanded(
                              flex: 37,
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: listOfIntialMessage[index]
                                              .bookerName,
                                          style: const TextStyle(
                                              color: Colors.orange)),
                                      const TextSpan(
                                          text:
                                              " have successfully booked service "),
                                      TextSpan(
                                          text: listOfIntialMessage[index]
                                              .serviceName,
                                          style: const TextStyle(
                                              color: Colors.green))
                                    ]),
                              )),
                          const Spacer(
                            flex: 5,
                          ),
                          Expanded(
                              flex: 37,
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: listOfIntialMessage[index]
                                              .timeSlot,
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      const TextSpan(
                                          text: " slot has reserved for Date "),
                                      TextSpan(
                                          text: carWashDate,
                                          style: const TextStyle(
                                              color: Colors.blue)),
                                    ]),
                              )),
                          const Spacer(
                            flex: 3,
                          ),
                          Expanded(
                              flex: 14,
                              child: Row(
                                children: [
                                  const Spacer(
                                    flex: 50,
                                  ),
                                  Expanded(
                                      flex: 50,
                                      child: FittedBox(
                                          child: Text(
                                              notificationDeleiveredData))),
                                ],
                              )),
                          const Spacer(
                            flex: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
