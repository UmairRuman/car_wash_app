import 'package:car_wash_app/Admin/Pages/edit_profile_page/controller/edit_profile_state_controller.dart';
import 'package:car_wash_app/Client/pages/home_page/Controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminButtonUpdateUserInfo extends ConsumerWidget {
  const AdminButtonUpdateUserInfo({super.key});

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
                  onPressed: () async {
                    await ref
                        .read(adminSideEditProfileInfoProvider.notifier)
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
