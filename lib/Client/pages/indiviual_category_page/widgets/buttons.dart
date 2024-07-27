import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_rating_dialog.dart';
import 'package:car_wash_app/Controllers/booking_controller.dart';
import 'package:car_wash_app/payment_methods/model/data_sender_model.dart';
import 'package:car_wash_app/payment_methods/view/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonBookAWash extends ConsumerStatefulWidget {
  final String serviceName;
  final String serviceId;
  final String serviceImageUrl;

  const ButtonBookAWash(
      {super.key,
      required this.serviceId,
      required this.serviceImageUrl,
      required this.serviceName});

  @override
  ConsumerState<ButtonBookAWash> createState() => _ButtonBookAWashState();
}

class _ButtonBookAWashState extends ConsumerState<ButtonBookAWash>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationForSize;
  Tween<double> tween = Tween(begin: 1.0, end: 0.9);
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animationForSize = tween.animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1.0;
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
            child: ScaleTransition(
              scale: animationForSize,
              child: FloatingActionButton(
                onPressed: () async {
                  await animationController.forward();
                  await Future.delayed(const Duration(milliseconds: 100));
                  await animationController.reverse();
                  var carPrice =
                      ref.read(bookingStateProvider.notifier).carPrice;
                  var isCarAssetImage =
                      ref.read(bookingStateProvider.notifier).isCarAssetImage;
                  var carName = ref.read(bookingStateProvider.notifier).carType;
                  var selectedDate =
                      ref.read(bookingStateProvider.notifier).carWashDate;
                  var carImage =
                      ref.read(bookingStateProvider.notifier).carImagePath;
                  var timeSlot =
                      ref.read(bookingStateProvider.notifier).timeSlot;
                  // ref
                  //     .read(bookingStateProvider.notifier)
                  //     .addBooking(serviceId, serviceName, serviceImageUrl);
                  if (carPrice != null &&
                      isCarAssetImage != null &&
                      carName != null &&
                      selectedDate != null &&
                      carImage != null &&
                      timeSlot != null) {
                    Navigator.of(context).pushNamed(PaymentPage.pageName,
                        arguments: BookingPageDataSendingModel(
                            serviceId: widget.serviceId,
                            serviceImagePath: widget.serviceImageUrl,
                            serviceName: widget.serviceName,
                            isCarAssetImage: isCarAssetImage,
                            imagePath: carImage,
                            carName: carName,
                            price: carPrice,
                            timeSlot: timeSlot,
                            dateTime: selectedDate));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Kindly Choose all the given fields")));
                  }
                },
                backgroundColor: Colors.blue,
                child: const Text(
                  "Book Service",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
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
                  dialogForRating(
                      context, ref, widget.serviceName, widget.serviceId);
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
