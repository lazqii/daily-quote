import 'package:daily_quote/home/home_view.dart';
import 'package:daily_quote/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_quote/navigation_bar/app_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final isLoggedIn = preferences.getBool('is_logged_in') ?? false;

  runApp(MyApp(initiallyLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final initiallyLoggedIn;
  const MyApp({super.key, required this.initiallyLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Router',
      debugShowCheckedModeBanner: false,
      home: initiallyLoggedIn ? const HomePage() : const LoginPage(),
      // routerConfig: AppNavigation.router,
    );
  }
}
