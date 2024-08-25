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
          decoration: const BoxDecoration(color: Colors.blue),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, bottom: 20, top: 5),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-5, -5),
                        blurRadius: 5,
                        color: Color.fromARGB(255, 138, 193, 238)),
                    BoxShadow(
                        offset: Offset(5, 5),
                        blurRadius: 5,
                        color: Color.fromARGB(255, 138, 193, 238))
                  ]),
              child: Column(
                children: [
                  Expanded(
                      flex: 10,
                      child: BookingServiceText(serviceName: data.serviceName)),
                  Expanded(
                      flex: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
