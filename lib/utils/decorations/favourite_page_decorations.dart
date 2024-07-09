import 'package:flutter/material.dart';

var favouritePageContainerDecoration = const BoxDecoration(
    color: Color.fromARGB(255, 255, 251, 251),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30), topRight: Radius.circular(20)));

var favouriteCategoryContainerDecoration = const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          offset: Offset(3, -3),
          color: Color.fromARGB(255, 151, 188, 219),
          blurRadius: 3)
    ],
    borderRadius: BorderRadius.all(Radius.circular(20)));
