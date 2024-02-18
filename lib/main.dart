import 'package:flutter/material.dart';
import 'package:movieflix/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          displayMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
          displaySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
          bodyLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
