import 'package:car_wash_app/Admin/Pages/category_page/Widget/builder_widget_search_bar.dart';
import 'package:car_wash_app/Admin/Pages/category_page/Widget/filter_search_controller.dart';
import 'package:car_wash_app/ModelClasses/car_wash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SearchPage extends ConsumerWidget {
  final List<Services> services;

  const SearchPage({super.key, required this.services});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Services'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 8, left: 8.0, right: 8),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       labelText: "Search service",
          //       labelStyle: const TextStyle(color: Colors.blue),
          //       fillColor: const Color.fromARGB(255, 237, 234, 234),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide: const BorderSide(
          //           color: Colors.blue,
          //           width: 1.0,
          //         ),
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //     ),
          //     onChanged: (query) {
          //       ref
          //           .read(filterSearchListProvider.notifier)
          //           .searchService(query); // Custom method to filter services
          //     },
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchableList<Services>(
                inputDecoration: InputDecoration(
                  labelText: "Search service",
                  labelStyle: const TextStyle(color: Colors.blue),
                  fillColor: const Color.fromARGB(255, 237, 234, 234),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                initialList: ref.watch(filterSearchListProvider),
                itemBuilder: (Services service) =>
                    BuilderWidgetSearchBar(service: service),
                filter: (value) => services
                    .where(
                      (element) =>
                          element.serviceName.toLowerCase().contains(value),
                    )
                    .toList(),
                emptyWidget: const Center(
                  child: Text(
                    "No service found",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
