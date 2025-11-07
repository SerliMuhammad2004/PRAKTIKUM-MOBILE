import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

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
      home: HomeScreen(),
    );
  }
}
