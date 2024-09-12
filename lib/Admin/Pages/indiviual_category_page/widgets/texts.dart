import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/Dialogs/edit_car_model_info.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideTextChooseYourCarModel extends ConsumerWidget {
  final String serviceName;
  final String serviceId;

  const AdminSideTextChooseYourCarModel({
    super.key,
    required this.serviceId,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        const Expanded(
          flex: 40,
          child: FittedBox(
            child: Text(
              stringChooseYourCarModel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(flex: 10, child: Icon(Icons.arrow_forward)),
        const Spacer(
          flex: 25,
        ),
        Expanded(
          flex: 15,
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
            child: InkWell(
              onTap: () {
                dialogForEditCarInfo(context, serviceName, serviceId, ref);
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 201, 218, 232),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(Icons.no_crash_outlined)),
            ),
          ),
        ),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}

class CategoryTextDescription extends StatelessWidget {
  const CategoryTextDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(),
      cursorColor: Colors.red,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        hintText: 'Title',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
