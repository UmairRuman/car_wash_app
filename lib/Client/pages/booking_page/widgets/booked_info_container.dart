import 'package:car_wash_app/Client/pages/booking_page/widgets/booked_service_image.dart';
import 'package:car_wash_app/Client/pages/booking_page/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BookedInfoContainer extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String bookingServiceName;
  final String bookingDate;
  final String timeSlot;
  final String washPrice;
  final String bookingStatus;
  const BookedInfoContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.imagePath,
      required this.bookingServiceName,
      required this.bookingDate,
      required this.timeSlot,
      required this.washPrice,
      required this.bookingStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                offset: Offset(3, 3),
                blurRadius: 3,
                color: const Color.fromARGB(255, 109, 177, 233))
          ],
          color: const Color.fromARGB(255, 242, 238, 238),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(flex: 40, child: BookedServiceImage(imagepath: imagePath)),
            const Spacer(
              flex: 3,
            ),
            Expanded(
                flex: 52,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 5,
                    ),
                    Expanded(
                        flex: 18,
                        child: BookedServiceName(
                            bookingServiceName: bookingServiceName)),
                    Expanded(
                      flex: 18,
                      child: TextBookingDate(
                        bookingDate: bookingDate,
                      ),
                    ),
                    Expanded(
                      flex: 18,
                      child: TextBookingTimeSlot(timeSlot: timeSlot),
                    ),
                    Expanded(
                        flex: 18,
                        child: TextBookingWashPrice(washPrice: washPrice)),
                    Expanded(
                        flex: 18,
                        child: BookingStatus(bookingStatus: bookingStatus)),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                )),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
