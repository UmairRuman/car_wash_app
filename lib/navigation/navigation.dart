import 'package:car_wash_app/Admin/Pages/booking_page/view/booking_page.dart';
import 'package:car_wash_app/Admin/Pages/category_page/View/admin_side_categoryPage.dart';
import 'package:car_wash_app/Admin/Pages/edit_profile_page/view/edit_profile_page.dart';
import 'package:car_wash_app/Admin/Pages/home_page/view/admin_side_home_page.dart';
import 'package:car_wash_app/Admin/Pages/indiviual_category_page/view/admin_side_indiviual_category_page.dart';
import 'package:car_wash_app/Admin/Pages/profile_page/view/profile_page.dart';
import 'package:car_wash_app/Admin/Pages/NotificationPage/view/notification_page.dart';
import 'package:car_wash_app/Client/pages/ErrorPage/error_page.dart';
import 'package:car_wash_app/Client/pages/NotificationPage/view/notification_page.dart';
import 'package:car_wash_app/Client/pages/booking_page/view/booking_page.dart';
import 'package:car_wash_app/Client/pages/category_page/View/categoryPage.dart';
import 'package:car_wash_app/Client/pages/chooser_page/view/chooser_page.dart';
import 'package:car_wash_app/Client/pages/email_verification_page/view/verification_page.dart';
import 'package:car_wash_app/Client/pages/favourite_page/view/favourite_page.dart';
import 'package:car_wash_app/Client/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/Client/pages/home_page/view/home_page.dart';
import 'package:car_wash_app/Client/pages/indiviual_category_page/view/indiviual_category_page.dart';
import 'package:car_wash_app/Client/pages/login_page/view/login_page.dart';
import 'package:car_wash_app/Client/pages/profile_page/view/profile_page.dart';
import 'package:car_wash_app/Client/pages/reset_password_page/view/reset_password.dart';
import 'package:car_wash_app/Client/pages/sign_up_page/view/sign_up_page.dart';
import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/payment_methods/view/payment_page.dart';
import 'package:flutter/material.dart';

Route? onGenerateRoute(RouteSettings settings) {
  return switch (settings.name) {
    FirstPage.pageName => myPageBuilder(const FirstPage()),
    LoginPage.pageName => myPageBuilder(const LoginPage()),
    SignUpPage.pageName => myPageBuilder(const SignUpPage()),
    FavouritePage.pageName => myPageBuilder(const FavouritePage()),
    BookingPage.pageName => myPageBuilder(const BookingPage()),
    HomePage.pageName => myPageBuilder(const HomePage()),
    CategoryPage.pageName => myPageBuilder(const CategoryPage(
        location: "",
        profilePic: "",
        userName: "",
      )),
    ProfilePage.pageName => myPageBuilder(const ProfilePage()),
    ChooserPage.pageName => myPageBuilder(const ChooserPage()),
    NotificationPage.pageName => myPageBuilder(const NotificationPage()),
    IndiviualCategoryPage.pageName =>
      myPageBuilder(const IndiviualCategoryPage(), settings),
    AdminSideHomePage.pageName => myPageBuilder(const AdminSideHomePage()),
    AdminSideCategoryPage.pageName => myPageBuilder(const AdminSideCategoryPage(
        location: "",
        profilePic: "",
        userName: "",
      )),
    AdminSideEditProfilePage.pageName =>
      myPageBuilder(const AdminSideEditProfilePage(), settings),
    PaymentPage.pageName => myPageBuilder(const PaymentPage(), settings),
    AdminSideNotificationPage.pageName =>
      myPageBuilder(const AdminSideNotificationPage(), settings),
    AdminSideBookingPage.pageName =>
      myPageBuilder(const AdminSideBookingPage()),
    AdminSideProfilePage.pageName =>
      myPageBuilder(const AdminSideProfilePage()),
    EmailVerficationPage.pageName =>
      myPageBuilder(const EmailVerficationPage(), settings),
    AuthHandler.pageName => myPageBuilder(const AuthHandler()),
    ResetPasswordPage.pageName => myPageBuilder(const ResetPasswordPage()),
    AdminSideIndiviualCategoryPage.pageName =>
      myPageBuilder(const AdminSideIndiviualCategoryPage(), settings),
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
