import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class CheckBoxTermsAndCondition extends StatefulWidget {
  const CheckBoxTermsAndCondition({super.key});

  @override
  State<CheckBoxTermsAndCondition> createState() =>
      _CheckBoxTermsAndConditionState();
}

class _CheckBoxTermsAndConditionState extends State<CheckBoxTermsAndCondition> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
            flex: 10,
            child: Checkbox(
              activeColor: Colors.purple,
              focusColor: Colors.purple,
              value: value,
              onChanged: (value) {
                setState(() {
                  this.value = value!;
                });
              },
            )),
        Expanded(flex: 30, child: FittedBox(child: Text(stringReadAndAgreeTo))),
        const Spacer(
          flex: 2,
        ),
        Expanded(
            flex: 35,
            child: FittedBox(
              child: Text(
                stringTermsAndCondition,
                style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            )),
        const Spacer(
          flex: 13,
        )
      ],
    );
  }
}
