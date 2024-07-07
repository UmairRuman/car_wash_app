import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

class IndiviualCategoryImage extends StatelessWidget {
  final String imagePath;
  const IndiviualCategoryImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(8, 8),
                      blurRadius: 8,
                      color: Color.fromARGB(255, 216, 210, 210)),
                  BoxShadow(
                      offset: Offset(-8, -8),
                      blurRadius: 8,
                      color: Color.fromARGB(255, 216, 210, 210))
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
