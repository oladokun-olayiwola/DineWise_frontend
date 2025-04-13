import 'package:flutter/material.dart';
import 'package:nutri_budget/screens/health_rating_screen.dart';
import 'package:nutri_budget/screens/homepage.dart';
import 'package:nutri_budget/screens/onboarding.dart';
import 'package:nutri_budget/screens/recommendation.dart';
import 'package:nutri_budget/screens/splashscreen.dart';
import 'package:nutri_budget/screens/step1.dart';
import 'package:nutri_budget/screens/step2.dart';


void main() {
  runApp(MaterialApp(
    //home: SplashScreen(),

    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) =>  SplashScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/first': (context) =>  LunchTimeScreen(),
      '/second': (context) =>  IngredientAllergiesScreen(),
      '/third': (context) =>  Diets(),
      '/fourth': (context) =>  HomeScreenn(),

    },
    debugShowCheckedModeBanner: false,
  ));
}
