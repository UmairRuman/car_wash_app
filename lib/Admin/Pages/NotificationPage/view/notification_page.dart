import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/Admin/Pages/NotificationPage/widget/messsage_intial_widget.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/controller/messages_state_controller.dart';
import 'package:car_wash_app/utils/images_path.dart';
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(flex: 20, child: Image.asset(notificationPageImage)),
          ],
        ),
      ),
      body: Center(
        child: Builder(builder: (context) {
          if (state is MessageIntialState) {
            return AdminSideMesssageIntialWidget(
                listOfIntialMessage: listOfIntialMessages);
          } else if (state is MessageLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is MessageLoadedState) {
            return LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                itemCount: state.listOfMessageModel.length,
                itemBuilder: (context, index) {
                  DateTime dateTime =
                      state.listOfMessageModel[index].carWashDate;
                  String carWashDate =
                      "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: constraints.maxHeight * 0.12,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: const Color.fromARGB(255, 156, 199, 235),
                              offset: Offset(5, 5),
                              blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 50,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 30,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        state
                                                            .listOfMessageModel[
                                                                index]
                                                            .bookerPic),
                                                fit: BoxFit.fill)),
                                        child: state.listOfMessageModel[index]
                                                    .bookerPic ==
                                                ""
                                            ? Image.asset(emptyImage)
                                            : CachedNetworkImage(
                                                imageUrl: state
                                                    .listOfMessageModel[index]
                                                    .bookerPic,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      )),
                                  const Spacer(
                                    flex: 50,
                                  )
                                ],
                              )),
                          Expanded(
                            flex: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  const Spacer(
                                    flex: 5,
                                  ),
                                  Expanded(
                                      flex: 40,
                                      child: RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(
                                                  text: state
                                                      .listOfMessageModel[index]
                                                      .bookerName,
                                                  style: const TextStyle(
                                                      color: Colors.orange)),
                                              const TextSpan(
                                                  text:
                                                      " have successfully booked service "),
                                              TextSpan(
                                                  text: state
                                                      .listOfMessageModel[index]
                                                      .serviceName,
                                                  style: const TextStyle(
                                                      color: Colors.green))
                                            ]),
                                      )),
                                  const Spacer(
                                    flex: 10,
                                  ),
                                  Expanded(
                                      flex: 40,
                                      child: RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: state
                                                      .listOfMessageModel[index]
                                                      .timeSlot,
                                                  style: const TextStyle(
                                                      color: Colors.red)),
                                              const TextSpan(
                                                  text:
                                                      " slot has reserved for Date "),
                                              TextSpan(
                                                  text: carWashDate,
                                                  style: const TextStyle(
                                                      color: Colors.blue)),
                                            ]),
                                      )),
                                  const Spacer(
                                    flex: 5,
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
          } else {
            String error = (state as MessageErrorState).error;
            return Text(error);
          }
        }),
      ),
    ));
  }
}
