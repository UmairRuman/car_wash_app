import 'package:car_wash_app/Client/pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/buttons.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/car_model_container.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/category_image.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/date_time_line.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/selected_date.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/texts.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/time_slots.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/top_row.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndiviualCategoryPage extends ConsumerWidget {
  static const String pageName = "/individualCategoryPage";
  const IndiviualCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(allServiceDataStateProvider);

    var data =
        ModalRoute.of(context)!.settings.arguments as ImageAndServiceNameSender;
    String serviceId = data.serviceID;
    String imagePath = data.imagePath;
    String serviceName = data.categoryName;
    // ref
    //     .read(allServiceDataStateProvider.notifier)
    //     .getServiceName(serviceName, imagePath);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (context) {
        if (state is DataLoadedState) {
          var name = state.service.serviceName;
          var serviceImage = state.service.imageUrl;
          var serviceDescription = state.service.description;
          var listOfDates = state.service.availableDates;
          var phoneNumber = state.service.adminPhoneNo;
          bool isAssetImage = state.service.isAssetImage;
          bool isFavourite = state.service.isFavourite;
          List<Car> listOfCars = state.service.cars;
          return Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              Expanded(
                  flex: 5,
                  child: TopRowIndiviualCategoryPage(
                    serviceImageUrl: serviceImage,
                    serviceId: serviceId,
                    isFavourite: isFavourite,
                    serviceName: name,
                  )),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                  flex: 19,
                  child: IndiviualCategoryImage(
                    adminPhoneNumber: phoneNumber,
                    isAssetImage: isAssetImage,
                    description: serviceDescription,
                    imagePath: serviceImage,
                  )),
              const Expanded(
                flex: 5,
                child: TextChooseYourCarModel(),
              ),
              Expanded(
                  flex: 14,
                  child: CarModelContainer(
                    listOfCars: listOfCars,
                  )),
              const Spacer(
                flex: 2,
              ),
              const Expanded(flex: 5, child: TextSelectDate()),
              Expanded(
                  flex: 17,
                  child: DateTimePicker(
                    serviceId: serviceId,
                    serviceName: serviceName,
                  )),
              const Expanded(flex: 5, child: TextChooseTimeSlot()),
              const Expanded(flex: 10, child: ClientSideTimeSlots()),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                  flex: 12,
                  child: ButtonBookAWash(
                    serviceId: serviceId,
                    serviceImageUrl: serviceImage,
                    serviceName: serviceName,
                  )),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    ));
  }
}
