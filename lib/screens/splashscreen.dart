import 'package:flutter/material.dart';
import 'dart:async';

import 'package:nutri_budget/main.dart';
import 'package:nutri_budget/screens/onboarding.dart';
import 'package:nutri_budget/screens/recommendation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Initial opacity for the text
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; // Update the opacity to make the text fully visible
      });
    });

    // Set a timer to navigate to the next screen after a delay
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LunchTimeScreen(),
        ), // Replace HomeScreen with your next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green.shade800, // Set the background color
      body: Center(
        child: SizedBox(
          width:
              double.infinity, // Ensures the container takes up the full width
          height:
              double.infinity, // Ensures the container takes up the full height
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.greenAccent, // Start color
                Colors.green, // End color
              ],
              begin: Alignment.topLeft, // Gradient starting point
              end: Alignment.bottomRight, // Gradient ending point
            ),
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your logo or image here
              /*Image.asset(
                'images/updated.png', // Replace with your logo's asset path
                height: 150,
              ),
              SizedBox(height: 20),*/
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 3), // Animation duration
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'D',
                        style: TextStyle(
                          //fontFamily: 'Ethnocentric',
                          fontStyle: FontStyle.italic,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Custom color for D
                        ),
                      ),
                      TextSpan(
                        text: 'inewise Pro',
                        style: TextStyle(
                          //fontFamily: 'Roboto',
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Add a loading indicator
              /*CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

// Example of a simple HomeScreen after the splash
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(child: Text('Welcome to the app!')),
    );
  }
}

/*void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}*/
