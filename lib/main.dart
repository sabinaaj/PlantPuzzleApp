import 'package:flutter/material.dart';
import 'screens/area_list_page.dart';
import 'screens/login_page.dart';
import '../utilities/user_storage.dart';
import 'themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If the user is not logged in, show the login page
        if (snapshot.hasData && !snapshot.data!) {
          return LoginPage();
        }

        // If the user is logged in, show the home page
        return const AreaListPage();
      },
    );
  }
}