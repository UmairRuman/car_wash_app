import 'package:car_wash_app/Client/pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/car_model_container.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/category_image.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/date_time_line.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/selected_date.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/texts.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/time_slot.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/top_row.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class IndiviualCategoryPage extends StatelessWidget {
  static const String pageName = "/individualCategoryPage";
  const IndiviualCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments ??
        ImageAndServiceNameSender(
            categoryName: listOfCategoryName[1],
            imagePath: listOfPreviousWorkImages[1]);
    String imagePath = (data as ImageAndServiceNameSender).imagePath;
    String serviceName = data.categoryName;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 3,
          ),
          Expanded(
              flex: 5,
              child: TopRowIndiviualCategoryPage(
                serviceName: serviceName,
              )),
          const Spacer(
            flex: 2,
          ),
          Expanded(
              flex: 20,
              child: IndiviualCategoryImage(
                imagePath: imagePath,
              )),
          const Expanded(
            flex: 5,
            child: TextChooseYourCarModel(),
          ),
          const Expanded(flex: 15, child: CarModelContainer()),
          const Spacer(
            flex: 2,
          ),
          const Expanded(flex: 5, child: TextSelectDate()),
          const Expanded(flex: 15, child: DateTimePicker()),
          const Expanded(flex: 5, child: TextChooseTimeSlot()),
          const Expanded(flex: 10, child: TimeSlot()),
          const Spacer(
            flex: 3,
          ),
          const Expanded(flex: 8, child: ButtonBookAWash()),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    ));
  }
}
