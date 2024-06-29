import 'package:car_wash_app/pages/indiviual_category_page/widgets/buttons.dart';
import 'package:car_wash_app/pages/indiviual_category_page/widgets/car_model_container.dart';
import 'package:car_wash_app/pages/indiviual_category_page/widgets/category_image.dart';
import 'package:car_wash_app/pages/indiviual_category_page/widgets/date_time_line.dart';
import 'package:car_wash_app/pages/indiviual_category_page/widgets/selected_date.dart';
import 'package:car_wash_app/pages/indiviual_category_page/widgets/texts.dart';
import 'package:car_wash_app/pages/indiviual_category_page/widgets/time_slot.dart';
import 'package:car_wash_app/pages/indiviual_category_page/widgets/top_row.dart';
import 'package:flutter/material.dart';

class IndiviualCategoryPage extends StatelessWidget {
  const IndiviualCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Spacer(
            flex: 3,
          ),
          Expanded(flex: 5, child: TopRowIndiviualCategoryPage()),
          Spacer(
            flex: 2,
          ),
          Expanded(flex: 20, child: IndiviualCategoryImage()),
          Expanded(
            flex: 5,
            child: TextChooseYourCarModel(),
          ),
          Expanded(flex: 15, child: CarModelContainer()),
          Spacer(
            flex: 2,
          ),
          Expanded(flex: 5, child: TextSelectDate()),
          Expanded(flex: 15, child: DateTimePicker()),
          Expanded(flex: 5, child: TextChooseTimeSlot()),
          Expanded(flex: 10, child: TimeSlot()),
          Spacer(
            flex: 3,
          ),
          Expanded(flex: 8, child: ButtonBookAWash()),
          Spacer(
            flex: 2,
          )
        ],
      ),
    ));
  }
}
