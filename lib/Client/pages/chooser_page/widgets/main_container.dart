import 'package:car_wash_app/Client/pages/chooser_page/controller/location_notifier.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/authenticate_phone_no.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/choices.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/get_location_info.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooserPageMainContainer extends ConsumerWidget {
  const ChooserPageMainContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var location = ref.watch(locationProvider);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(offset: Offset(3, 3), color: Colors.blue, blurRadius: 3),
            BoxShadow(offset: Offset(-3, -3), blurRadius: 3, color: Colors.blue)
          ]),
      child: Column(
        children: [
          const Spacer(
            flex: 7,
          ),
          if (location.country != null && location.locality != null)
            const Expanded(flex: 5, child: CurrentLocationText()),
          const Expanded(flex: 10, child: BtnAddLocationChooserPage()),
          const Expanded(flex: 15, child: ChooserPagePhoneNumber()),
          const Expanded(flex: 10, child: BtnVerifyChooserPage()),
          const Expanded(flex: 13, child: PhoneNoOTP()),
          const Expanded(flex: 5, child: BtnAuthenticatePhoneNo()),
          const Expanded(flex: 5, child: ChoiceText()),
          const Expanded(
              flex: 20,
              child: Row(
                children: [
                  Spacer(
                    flex: 5,
                  ),
                  Expanded(flex: 40, child: Choice1()),
                  Spacer(
                    flex: 10,
                  ),
                  Expanded(flex: 40, child: Choice2()),
                  Spacer(
                    flex: 5,
                  ),
                ],
              )),
          const Expanded(flex: 8, child: BtnContinueChooserPage()),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
