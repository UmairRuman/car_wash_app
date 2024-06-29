import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  static const String pageName = "/errorPage";
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Error Page")),
    );
  }
}
