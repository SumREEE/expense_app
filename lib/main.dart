import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // << เอาแถบ DEBUG ออก
      title: 'ExpenseApp By THANAWAT204',
      theme: ThemeData(
        primaryColor: Colors.purple,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
        ),
      ),
      home: const StartScreen(),
    );
  }
}
