import 'package:car_wash_app/pages/ErrorPage/error_page.dart';
import 'package:car_wash_app/pages/booking_page/view/booking_page.dart';
import 'package:car_wash_app/pages/category_page/View/categoryPage.dart';
import 'package:car_wash_app/pages/favourite_page/view/favourite_page.dart';
import 'package:car_wash_app/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/pages/indiviual_category_page/view/indiviual_category_page.dart';
import 'package:car_wash_app/pages/login_page/view/login_page.dart';
import 'package:car_wash_app/pages/profile_page/view/profile_page.dart';
import 'package:car_wash_app/pages/sign_up_page/view/sign_up_page.dart';
import 'package:flutter/material.dart';

Route? onGenerateRoute(RouteSettings settings) {
  return switch (settings.name) {
    FirstPage.pageName => myPageBuilder(const FirstPage()),
    LoginPage.pageName => myPageBuilder(const LoginPage()),
    SignUpPage.pageName => myPageBuilder(const SignUpPage()),
    FavouritePage.pageName => myPageBuilder(const FavouritePage()),
    BookingPage.pageName => myPageBuilder(const BookingPage()),
    HomePage.pageName => myPageBuilder(const HomePage()),
    CategoryPage.pageName => myPageBuilder(const CategoryPage()),
    ProfilePage.pageName => myPageBuilder(const ProfilePage()),
    IndiviualCategoryPage.pageName =>
      myPageBuilder(const IndiviualCategoryPage(), settings),
    _ => myPageBuilder(const ErrorPage())
  };
}

PageRouteBuilder myPageBuilder(Widget page, [RouteSettings? settings]) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) {
      return AnimatedOpacity(
        opacity: animation.value,
        duration: const Duration(seconds: 1),
        curve: Curves.bounceInOut,
        child: page,
      );
    },
  );
}
