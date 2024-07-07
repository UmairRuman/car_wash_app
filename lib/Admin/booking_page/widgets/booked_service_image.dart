import 'package:flutter/widgets.dart';

class BookedServiceImage extends StatelessWidget {
  final String imagepath;
  const BookedServiceImage({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover)),
    );
  }
}
