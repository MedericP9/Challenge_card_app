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
      title: 'Défis Cartes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}