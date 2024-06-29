import 'package:car_wash_app/navigation/navigation.dart';
import 'package:car_wash_app/pages/first_page/view/first_page.dart';
import 'package:car_wash_app/pages/home_page/view/bottom_navigation_bar.dart';
import 'package:car_wash_app/pages/indiviual_category_page/view/indiviual_category_page.dart';
import 'package:car_wash_app/pages/sign_up_page/controller/auth_state_change_notifier.dart';
import 'package:car_wash_app/utils/images_path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    for (var imagespath in listOfPreviousWorkImages) {
      precacheImage(AssetImage(imagespath), context);
    }

    return ProviderScope(
      child: MaterialApp(
        initialRoute: FirstPage.pageName,
        onGenerateRoute: onGenerateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const IndiviualCategoryPage(),
      ),
    );
  }
}

class AuthHandler extends ConsumerWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const FirstPage();
        } else {
          return const HomePage();
        }
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Something went wrong: $error'),
        ),
      ),
    );
  }
}
