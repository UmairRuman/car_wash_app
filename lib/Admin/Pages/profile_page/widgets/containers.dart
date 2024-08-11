import 'package:car_wash_app/utils/profile_page_resources.dart';
import 'package:flutter/material.dart';

class AdminSideProfileInfoContainersList extends StatelessWidget {
  final List list;
  const AdminSideProfileInfoContainersList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(children: [
        for (int i = 0; i < list.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: constraints.maxHeight / 6.5,
              width: constraints.maxWidth,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 122, 179, 226),
                    offset: Offset(3, 3),
                    blurRadius: 3)
              ]),
              child: Row(
                children: [
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                      flex: 10,
                      child: Icon(
                        adminlistOfProfileIcons[i],
                        color: Colors.blue,
                      )),
                  Expanded(
                      flex: 30,
                      child: Text(
                        adminListOfInfo[i],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                      flex: 40,
                      child: (list[i] as String).length >= 20
                          ? FittedBox(child: Text(list[i]))
                          : Text(
                              list[i],
                              textAlign: TextAlign.center,
                            )),
                  const Spacer(
                    flex: 5,
                  )
                ],
              ),
            ),
          )
      ]),
    );
  }
}
