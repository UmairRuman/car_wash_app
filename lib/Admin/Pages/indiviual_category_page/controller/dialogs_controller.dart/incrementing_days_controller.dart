import 'package:car_wash_app/Admin/Pages/indiviual_category_page/controller/timeslot_controller.dart';
import 'package:car_wash_app/Collections.dart/sub_collections.dart/time_slot_collection.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/shraed_prefernces_constants.dart';
import 'package:car_wash_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final increamentingDaysStateProvider =
    NotifierProvider<IncrementingDaysController, String>(
        IncrementingDaysController.new);

class IncrementingDaysController extends Notifier<String> {
  final String adminId = prefs!.getString(SharedPreferncesConstants.adminkey)!;
  TimeSlotCollection timeSlotCollection = TimeSlotCollection();
  int intialShowingDates = 7;
  bool isDataChangedThroughIncreamentingDaysDialog = false;
  @override
  String build() {
    return "";
  }

  Future<void> onUpdateBtnClickToIncreamentDays(
      String serviceId, String serviceName) async {
    isDataChangedThroughIncreamentingDaysDialog = true;
    //Firstly we have to update no of days
    //Then we have to add slots in newly added days
    await ref
        .read(timeSlotsStateProvider.notifier)
        .addTimeSlots(intialShowingDates);

    ref
        .read(allServiceDataStateProvider.notifier)
        .updateService(serviceId, serviceName);
    ref.read(timeSlotsStateProvider.notifier).getTimeSlots(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );

    //After all process we have to get TimeSlots
  }
}
