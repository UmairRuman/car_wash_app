import 'package:car_wash_app/Client/pages/Search_bar/widgets/client_search_page.dart';
import 'package:car_wash_app/Controllers/all_service_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientHomePageSearchBar extends ConsumerWidget {
  const ClientHomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var intialListOfServices =
        ref.read(allServiceDataStateProvider.notifier).intialListOfService;

    return GestureDetector(
      onTap: () {
        // Navigate to the search page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ClientSearchPage(services: intialListOfServices),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.blue, width: 1.0),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              'Search service',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
