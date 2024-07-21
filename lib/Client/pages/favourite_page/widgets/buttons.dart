import 'package:car_wash_app/utils/strings.dart';
import 'package:flutter/material.dart';

class FavouriteCategoryBookButton extends StatelessWidget {
  const FavouriteCategoryBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 10,
        ),
        const Expanded(
            flex: 10,
            child: Row(
              children: [
                Spacer(
                  flex: 60,
                ),
                Expanded(
                  flex: 20,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                Spacer(
                  flex: 20,
                ),
              ],
            )),
        const Spacer(
          flex: 55,
        ),
        Expanded(
          flex: 25,
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: const FittedBox(
                  fit: BoxFit.none,
                  child: Text(
                    stringBookButton,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
