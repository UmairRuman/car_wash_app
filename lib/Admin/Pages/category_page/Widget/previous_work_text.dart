import 'package:car_wash_app/Admin/Pages/category_page/Widget/dialog.dart';
import 'package:car_wash_app/utils/strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomePagePreviousServiceText extends ConsumerWidget {
  const AdminHomePagePreviousServiceText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        const Expanded(
            flex: 25,
            child: FittedBox(
              child: Text(
                stringPreviousWork,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )),
        const Spacer(
          flex: 50,
        ),
        Expanded(
          flex: 15,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                final connectivityResult =
                    await Connectivity().checkConnectivity();
                if (connectivityResult[0] == ConnectivityResult.none) {
                  // No internet connection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No internet connection'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // Internet is connected, perform your operation here
                  dialogForAddingPreviousData(context, ref);
                }
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 201, 218, 232),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Icon(Icons.add)),
            ),
          ),
        ),
        const Spacer(
          flex: 5,
        )
      ],
    );
  }
}
