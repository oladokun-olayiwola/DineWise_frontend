
import 'dart:convert'; // For json.decode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'health_rating_screen.dart';

class HomeScreenn extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenn> {
  List<dynamic> mealRecommendations = []; // To store fetched meal recommendations
  bool isLoading = false; // To show loading spinner while fetching data
  TextEditingController _budgetController = TextEditingController();

  // Fetch meal recommendations from the backend
  Future<void> fetchMealRecommendations(String budget) async {
    String apiUrl = 'http://localhost:8080/api/recommendations'; // Backend API URL

    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('$apiUrl?budget=$budget'));

    if (response.statusCode == 200) {
      setState(() {
        mealRecommendations = json.decode(response.body); // Parse JSON response
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch recommendations')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:  Colors.pink[50],

      appBar: AppBar(
        title: Text('NutriBudget'),
        backgroundColor: Colors.white,
      ),

      body: Container(
        width: double.infinity, // Ensures the container takes up the full width
        height: double.infinity, // Ensures the container takes up the full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white, // Start color
              Colors.pink.shade50, // End color
            ],
            begin: Alignment.topLeft, // Gradient starting point
            end: Alignment.bottomRight, // Gradient ending point
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Your Budget',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _budgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter your budget',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: Colors.pink[50]
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )
                    ),
                    onPressed: () {
                      if (_budgetController.text.isNotEmpty) {
                        fetchMealRecommendations(_budgetController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a budget')),
                        );
                      }
                    },
                    child: Text('Get Meal Suggestions',style: TextStyle(color: Colors.black),),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: mealRecommendations.length,
                      itemBuilder: (context, index) {
                        final meal = mealRecommendations[index];

                        return Card(

                          //color: Colors.pink[50],
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HealthRatingScreen(meal: meal),
                                ),
                              );
                            },
                            leading: meal['imageUrl'] != null
                                ? Image.network(
                              meal['imageUrl'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                                : Icon(Icons.fastfood),
                            title: Text(meal['foodItem'] ?? 'No Name'),
                            subtitle: Text(
                              'Price: \₦${meal['price'] ?? '0'}\nCalories: ${meal['calories'] ?? 'N/A'}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}