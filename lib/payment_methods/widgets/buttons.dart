import 'package:car_wash_app/payment_methods/Stripe/stripe_services.dart';
import 'package:car_wash_app/payment_methods/paypal/paypal_services.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaypalPaymentMethodBtn extends ConsumerWidget {
  final String paymentAmount;
  final String serviceName;
  final String serviceImagePath;
  final String id;
  const PaypalPaymentMethodBtn(
      {super.key,
      required this.paymentAmount,
      required this.serviceName,
      required this.id,
      required this.serviceImagePath});

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
                onPressed: () {
                  var finalPayment = int.parse(
                      paymentAmount.substring(0, paymentAmount.length - 1));
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
                        ref),
                  ));
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
  const StripePaymentMethodBtn(
      {super.key,
      required this.paymentAmount,
      required this.id,
      required this.serviceImagePath,
      required this.serviceName});

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
                onPressed: () {
                  var finalPayment = int.parse(
                      paymentAmount.substring(0, paymentAmount.length - 1));
                  StripeServices.instance.makePayment(finalPayment, "usd", id,
                      serviceName, ref, serviceImagePath);
                },
                child: Image.asset(stripeImage))),
        const Spacer(
          flex: 20,
        )
      ],
    );
  }
}
