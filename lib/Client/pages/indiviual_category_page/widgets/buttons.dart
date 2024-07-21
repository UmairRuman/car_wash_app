import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_name_dialog.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonBookAWash extends ConsumerWidget {
  final String serviceName;
  final int serviceId;
  final String serviceImageUrl;

  const ButtonBookAWash(
      {super.key,
      required this.serviceId,
      required this.serviceImageUrl,
      required this.serviceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 187, 214, 237),
                offset: Offset(-3, -3),
                blurRadius: 3)
          ],
          color: Color.fromARGB(255, 252, 250, 250),
          borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(50, 50),
              topRight: Radius.elliptical(50, 50))),
      child: Row(
        children: [
          const Spacer(
            flex: 10,
          ),
          Expanded(
            flex: 60,
            child: FloatingActionButton(
              onPressed: () {
                ref
                    .read(bookingStateProvider.notifier)
                    .addBooking(serviceId, serviceName, serviceImageUrl);
              },
              backgroundColor: Colors.blue,
              child: const Text(
                "Book Service",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const Spacer(
            flex: 7,
          ),
          Expanded(
              flex: 15,
              child: InkWell(
                onTap: () {
                  dialogForRating(context);
                },
                child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 187, 214, 237),
                              offset: Offset(-3, -3),
                              blurRadius: 3),
                          BoxShadow(
                              color: Color.fromARGB(255, 187, 214, 237),
                              offset: Offset(3, 3),
                              blurRadius: 3)
                        ],
                        color: Color.fromARGB(255, 243, 245, 247),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 30,
                    )),
              )),
          const Spacer(
            flex: 8,
          ),
        ],
      ),
    );
  }
}
