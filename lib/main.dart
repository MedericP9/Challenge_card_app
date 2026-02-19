import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const DefiCartesApp());
}

class DefiCartesApp extends StatelessWidget {
  const DefiCartesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const HomePage(),
    );
  }
}