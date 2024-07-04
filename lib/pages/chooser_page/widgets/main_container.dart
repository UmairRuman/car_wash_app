import 'package:car_wash_app/pages/chooser_page/widgets/buttons.dart';
import 'package:car_wash_app/pages/chooser_page/widgets/choices.dart';
import 'package:car_wash_app/pages/chooser_page/widgets/text_fields.dart';
import 'package:flutter/material.dart';

var chooserPageNameKey = GlobalKey<FormState>();
var chooserPagePhoneNumberKey = GlobalKey<FormState>();

class ChooserPageMainContainer extends StatelessWidget {
  const ChooserPageMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
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
            flex: 10,
          ),
          const Expanded(flex: 10, child: BtnAddLocationChooserPage()),
          Expanded(
              flex: 15,
              child: ChooserPageNameTextField(formKey: chooserPageNameKey)),
          Expanded(
              flex: 15,
              child:
                  ChooserPagePhoneNumber(formKey: chooserPagePhoneNumberKey)),
          const Expanded(flex: 5, child: ChoiceText()),
          const Spacer(
            flex: 5,
          ),
          const Expanded(
              flex: 25,
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
          const Spacer(
            flex: 3,
          ),
          const Expanded(flex: 8, child: BtnContinueChooserPage()),
          Spacer(
            flex: 4,
          )
        ],
      ),
    );
  }
}
