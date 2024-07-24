import 'package:flutter/material.dart';

class SelectedCarContainer extends StatelessWidget {
  final bool isAssetImage;
  final String carName;
  final String carPic;
  final String carPrice;
  const SelectedCarContainer(
      {super.key,
      required this.carName,
      required this.carPic,
      required this.carPrice,
      required this.isAssetImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 249, 248, 248),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 143, 193, 234),
                offset: Offset(3, 3),
                blurRadius: 3)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 55,
              child:
                  isAssetImage ? Image.asset(carPic) : Image.network(carPic)),
          Expanded(
              flex: 25,
              child: Text(
                carName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          Expanded(
            flex: 15,
            child: Text(
              carPrice,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          const Spacer(
            flex: 5,
          )
        ],
      ),
    );
  }
}
