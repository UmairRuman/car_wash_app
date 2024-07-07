import 'package:car_wash_app/Controllers/user_state_controller.dart';
import 'package:car_wash_app/ModelClasses/map_for_User_info.dart';
import 'package:car_wash_app/Client/pages/chooser_page/controller/color_controller.dart';
import 'package:car_wash_app/Client/pages/chooser_page/widgets/sqare_shape_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoiceText extends StatelessWidget {
  const ChoiceText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 80,
          child: FittedBox(
              child: Text(
            "How you want to Join my app",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        Spacer(
          flex: 10,
        ),
      ],
    );
  }
}

class Choice1 extends ConsumerWidget {
  const Choice1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorProvider = ref.watch(colorNotifierProvider);
    var textColor = ref.read(colorNotifierProvider.notifier).customerTextColor;
    return LayoutBuilder(
      builder: (context, constraints) => ClipPath(
          clipper: SquareShapeClipper(),
          child: InkWell(
            onTap: () {
              ref
                  .read(colorNotifierProvider.notifier)
                  .onClickOnCustomerChoice();
              ref
                  .read(userAdditionStateProvider.notifier)
                  .listOfUserInfo[MapForUserInfo.userId] = false;
            },
            child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration:
                    BoxDecoration(color: colorProvider, boxShadow: const [
                  BoxShadow(
                    offset: Offset(5, 5),
                    color: Colors.blue,
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    offset: Offset(-5, -5),
                    color: Colors.blue,
                    blurRadius: 5,
                  )
                ]),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Client",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          )),
    );
  }
}

class Choice2 extends ConsumerWidget {
  const Choice2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(colorNotifierProvider);
    return LayoutBuilder(
      builder: (context, constraints) => ClipPath(
          clipper: SquareShapeClipper(),
          child: InkWell(
            onTap: () {
              ref
                  .read(colorNotifierProvider.notifier)
                  .onClickOnAttendentChoice();
              ref
                  .read(userAdditionStateProvider.notifier)
                  .listOfUserInfo[MapForUserInfo.isServiceProvider] = true;
            },
            child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                    color: ref
                        .watch(colorNotifierProvider.notifier)
                        .attendentBoxColor,
                    boxShadow: const [
                      BoxShadow(offset: Offset(3, 3), color: Colors.grey)
                    ]),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Admin",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ref
                              .watch(colorNotifierProvider.notifier)
                              .attendentTextColor),
                    ),
                  ),
                )),
          )),
    );
  }
}
