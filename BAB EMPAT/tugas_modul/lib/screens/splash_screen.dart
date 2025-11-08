import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home_screen.dart'; // Assuming you already have this

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Method to navigate to home after 4 seconds
  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 4)); // Wait for 4 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()), // Go to HomeScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // You can change the color
      body: Center(
        child: Text(
          'Welcome to Bloomora', // You can replace this with your logo or image
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
