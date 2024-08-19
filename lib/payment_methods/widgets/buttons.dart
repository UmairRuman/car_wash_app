import 'package:car_wash_app/payment_methods/Stripe/stripe_services.dart';
import 'package:car_wash_app/payment_methods/paypal/paypal_services.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaypalPaymentMethodBtn extends ConsumerWidget {
  final String paymentAmount;
  final String serviceName;
  final String serviceImagePath;
  final String id;
  final DateTime carWashDate;
  const PaypalPaymentMethodBtn(
      {super.key,
      required this.paymentAmount,
      required this.serviceName,
      required this.id,
      required this.serviceImagePath,
      required this.carWashDate});

  void onClickPaypalPaymentMethod(WidgetRef ref, BuildContext context) async {
    var finalPayment =
        int.parse(paymentAmount.substring(0, paymentAmount.length - 1));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => payPallmethod(
          context,
          finalPayment,
          <PaypalItems>[
            PaypalItems(
              name: serviceName,
              quantity: 1,
              price: finalPayment.toDouble(),
            )
          ],
          serviceName,
          serviceImagePath,
          id,
          carWashDate,
          ref),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 60,
            child: MaterialButton(
                onPressed: () async {
                  final connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult[0] == ConnectivityResult.none) {
                    // No internet connection
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No internet connection'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    onClickPaypalPaymentMethod(ref, context);
                  }
                },
                child: Image.asset(paypalImage))),
        const Spacer(
          flex: 20,
        )
      ],
    );
  }
}

class StripePaymentMethodBtn extends ConsumerWidget {
  final String paymentAmount;
  final String serviceName;
  final String serviceImagePath;
  final String id;
  final DateTime carWashDate;
  const StripePaymentMethodBtn(
      {super.key,
      required this.carWashDate,
      required this.paymentAmount,
      required this.id,
      required this.serviceImagePath,
      required this.serviceName});

  void onStripePaymentMethodClick(WidgetRef ref) {
    var finalPayment =
        int.parse(paymentAmount.substring(0, paymentAmount.length - 1));
    StripeServices.instance.makePayment(finalPayment, "usd", id, serviceName,
        ref, serviceImagePath, carWashDate);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 20,
        ),
        Expanded(
            flex: 60,
            child: MaterialButton(
                onPressed: () async {
                  final connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult[0] == ConnectivityResult.none) {
                    // No internet connection
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No internet connection'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    onStripePaymentMethodClick(ref);
                  }
                },
                child: Image.asset(stripeImage))),
        const Spacer(
          flex: 20,
        )
      ],
    );
  }
}
