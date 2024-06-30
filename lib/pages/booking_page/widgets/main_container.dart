import 'package:car_wash_app/pages/booking_page/widgets/booked_info_container.dart';
import 'package:car_wash_app/utils/booking_page_resources.dart';
import 'package:car_wash_app/utils/categoryInfo.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:car_wash_app/utils/indiviual_catergory_page_res.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView.builder(
          itemCount: listOFBookingDate.length,
          itemBuilder: (context, index) {
            return BookedInfoContainer(
              height: constraints.maxHeight / 4,
              width: constraints.maxWidth / 3,
              bookingDate: listOFBookingDate[index],
              bookingServiceName: listOfCategoryName[index],
              bookingStatus: listOfBookingStatus[index],
              imagePath: listOfPreviousWorkImages[index],
              timeSlot: listOfTimeSlots[index],
              washPrice: listOfBookingPrices[index],
            );
          },
        ),
      ),
    );
  }
}
