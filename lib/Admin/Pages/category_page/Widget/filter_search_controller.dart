import 'dart:developer';

import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterSearchListProvider =
    NotifierProvider<FilterSearchController, List<Services>>(
        FilterSearchController.new);

class FilterSearchController extends Notifier<List<Services>> {
  List<Services> intialList = [];
  @override
  List<Services> build() {
    findIntialServiceList();
    return intialList;
  }

  void findIntialServiceList() async {
    intialList =
        ref.read(allServiceDataStateProvider.notifier).intialListOfService;
    log("Intial list in Filter search controller $intialList");
  }

  void searchService(String query) {
    var intialListOfServices =
        ref.read(allServiceDataStateProvider.notifier).intialListOfService;
    final filteredList = intialListOfServices.where((service) {
      return service.serviceName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    state = filteredList;
  }
}
