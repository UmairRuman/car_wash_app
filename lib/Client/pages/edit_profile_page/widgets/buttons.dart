import 'package:car_wash_app/Client/pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonUpdateUserInfo extends ConsumerWidget {
  const ButtonUpdateUserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          const Spacer(
            flex: 20,
          ),
          Expanded(
              flex: 60,
              child: SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: MaterialButton(
                  onPressed: () {
                    ref
                        .read(editProfileInfoProvider.notifier)
                        .onClickOnUpdateButton(context);
                  },
                  color: Colors.blue,
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
          const Spacer(
            flex: 20,
          ),
        ],
      ),
    );
  }
}
