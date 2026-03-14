import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart'; // Ensure you have this file
import 'screens/main_wrapper.dart';

void main() {
  runApp(const TekMealsApp());
}

class TekMealsApp extends StatelessWidget {
  const TekMealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TekMeals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      // Define the home and the named routes
      home:  SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(), // The route the logout uses
        '/home': (context) =>  MainWrapper(),
      },
    );
  }
}