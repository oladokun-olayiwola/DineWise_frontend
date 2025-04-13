import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nutri_budget/screens/splashscreen.dart';

class NutriBudgetPage extends StatefulWidget {
  const NutriBudgetPage({super.key});

  @override
  _NutriBudgetPageState createState() => _NutriBudgetPageState();
}

class _NutriBudgetPageState extends State<NutriBudgetPage> {
  final TextEditingController _budgetController = TextEditingController();
  String? recommendation;
  bool isLoading = false;

  Future<void> getMealRecommendation() async {
    final budget = double.tryParse(_budgetController.text);
    if (budget == null) {
      setState(() {
        recommendation = "Please enter a valid number.";
      });
      return;
    }

    setState(() => isLoading = true);

    try {
      final url = Uri.parse(
        "http://192.168.x.x:8000/recommend",
      ); // Change to your backend IP!
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"budget": budget}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          recommendation =
          data.containsKey("price")
              ? "🍽️  Meal: ${data["meal"]}\n💵  Price: \$${data["price"]}\n🥦  Nutrition: ${data["nutrition"]}"
              : "❌ ${data["meal"]}";
        });
      } else {
        setState(() {
          recommendation = "Server Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        recommendation = "❌ Could not connect to server.";
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NutriBudget",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _budgetController,
              decoration: InputDecoration(
                labelText: "Enter your budget (\$)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 30),
            isLoading
                ? CircularProgressIndicator()
                : SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                onPressed: getMealRecommendation,
                child: Text(
                  "Get Meal Suggestion",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (recommendation != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  recommendation!,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}