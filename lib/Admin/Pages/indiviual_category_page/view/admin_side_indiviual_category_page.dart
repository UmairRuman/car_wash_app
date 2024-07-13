import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/buttons.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/car_model_container.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/categoryImage_and_description.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/date_time_line.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/selected_date.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/time_slot.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/widgets/top_row.dart';
import 'package:car_wash_app/Client/pages/category_page/Model/model_For_sending_data.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/widgets/texts.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminSideIndiviualCategoryPage extends ConsumerWidget {
  static const String pageName = "/adminSideindividualCategoryPage";
  const AdminSideIndiviualCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(allServiceDataStateProvider);

    var data =
        ModalRoute.of(context)!.settings.arguments as ImageAndServiceNameSender;
    int serviceId = data.serviceID;
    String imagePath = data.imagePath;
    String serviceName = data.categoryName;
    ref
        .read(allServiceDataStateProvider.notifier)
        .getServiceName(serviceName, imagePath);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (context) {
        if (state is DataLoadedState) {
          var serviceImage = state.service.imageUrl;
          var serviceDescription = state.service.description;
          var listOfDates = state.service.availableDates;
          List<Car> listOfCars = state.service.cars;
          return Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              Expanded(
                  flex: 5,
                  child: AdminSideTopRowIndiviualCategoryPage(
                    serviceName: serviceName,
                  )),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                  flex: 20,
                  child: AdminSideIndiviualCategoryImageAndDescription(
                    description: serviceDescription,
                    imagePath: serviceImage,
                  )),
              const Expanded(
                flex: 5,
                child: TextChooseYourCarModel(),
              ),
              Expanded(
                  flex: 15,
                  child: AdminSideCarModelContainer(
                    listOfCars: listOfCars,
                  )),
              const Spacer(
                flex: 2,
              ),
              const Expanded(flex: 5, child: AdminSideTextSelectDate()),
              Expanded(
                  flex: 15,
                  child: AdminSideDateTimePicker(
                    serviceId: serviceId,
                    serviceName: serviceName,
                  )),
              Expanded(
                  flex: 5,
                  child: AdminSideTextChooseTimeSlot(
                    serviceId: serviceId,
                    serviceName: serviceName,
                  )),
              const Expanded(flex: 10, child: AdminSideTimeSlot()),
              const Spacer(
                flex: 3,
              ),
              Expanded(
                  flex: 8,
                  child: ButtonSaveService(
                    serviceId: serviceId,
                  )),
              const Spacer(
                flex: 2,
              )
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
