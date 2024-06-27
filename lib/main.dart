import 'package:car_wash_app/HomePage/View/homePage.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    for (var imagespath in listOfPreviousWorkImages) {
      precacheImage(AssetImage(imagespath), context);
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
