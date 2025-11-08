import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import the SplashScreen
import 'screens/home_screen.dart';  // Import the HomeScreen

void main() {
  runApp(EComApp());
}

class EComApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloomora - Bouquet Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),  // Set SplashScreen as the initial screen
    );
  }
}