import 'package:car_wash_app/payment_methods/model/data_sender_model.dart';
import 'package:car_wash_app/payment_methods/widgets/buttons.dart';
import 'package:car_wash_app/payment_methods/widgets/selected_car_container.dart';
import 'package:car_wash_app/payment_methods/widgets/texts.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  static const pageName = "/paymentPage";
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments
        as BookingPageDataSendingModel;
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
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.blue
              // gradient: LinearGradient(
              //   begin: Alignment.topRight,
              //   end: Alignment.bottomLeft,
              //   stops: [0.3, 0.6, 0.9],
              //   colors: [
              //     Color.fromARGB(255, 187, 33, 243),
              //     Color.fromARGB(255, 233, 30, 220),
              //     Color.fromARGB(255, 108, 39, 176),
              //   ],
              // ),
              ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(70)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-10, -10),
                        blurRadius: 10,
                        color: Colors.blue),
                    BoxShadow(
                        offset: Offset(10, 10),
                        blurRadius: 10,
                        color: Colors.blue)
                  ]),
              child: Column(
                children: [
                  Expanded(
                      flex: 10,
                      child: BookingServiceText(serviceName: data.serviceName)),
                  Expanded(
                      flex: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SelectedCarContainer(
                          carName: data.carName,
                          carPic: data.imagePath,
                          carPrice: data.price,
                          isAssetImage: data.isCarAssetImage,
                        ),
                      )),
                  Expanded(
                      flex: 10,
                      child: BookingDateText(
                        bookingDate: data.dateTime,
                      )),
                  Expanded(
                      flex: 10,
                      child: BookingSlotText(
                        bookingSlot: data.timeSlot,
                      )),
                  const Spacer(
                    flex: 5,
                  ),
                  const Expanded(flex: 5, child: DisclaimerText()),
                  const Expanded(flex: 5, child: ChoosePaymmentMethodText()),
                  Expanded(
                      flex: 10,
                      child: PaypalPaymentMethodBtn(
                        carWashDate: data.dateTime,
                        id: data.serviceId,
                        serviceImagePath: data.serviceImagePath,
                        paymentAmount: data.price,
                        serviceName: data.serviceName,
                      )),
                  Expanded(
                      flex: 10,
                      child: StripePaymentMethodBtn(
                        carWashDate: data.dateTime,
                        id: data.serviceId,
                        serviceImagePath: data.serviceImagePath,
                        paymentAmount: data.price,
                        serviceName: data.serviceName,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
