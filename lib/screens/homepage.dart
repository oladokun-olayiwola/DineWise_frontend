import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'health_rating_screen.dart';
import 'package:flutter/foundation.dart';

class HomeScreenn extends StatefulWidget {
  const HomeScreenn({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenn> {
  List<dynamic> mealRecommendations = [];
  bool isLoading = false;
  final TextEditingController _budgetController = TextEditingController();

  // ✅ Dynamically get API base URL based on platform
  String getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080';
    } else if (Platform.isIOS) {
      return 'http://localhost:8080';
    } else if (Platform.isWindows ||
        Platform.isLinux ||
        Platform.isMacOS ||
        kIsWeb) {
      return 'http://localhost:8080';
    } else {
      throw UnsupportedError("Platform not supported");
    }
  }

  // ✅ Fetch meal recommendations
  Future<void> fetchMealRecommendations(String budget) async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl = '${getBaseUrl()}/api/recommendations?budget=$budget';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          mealRecommendations = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch recommendations')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // ✅ UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dinewise Pro'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.pink.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
                    child: Text(
                      'Get Meal Suggestions',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: mealRecommendations.length,
                      itemBuilder: (context, index) {
                        final meal = mealRecommendations[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          HealthRatingScreen(meal: meal),
                                ),
                              );
                            },
                            leading:
                                meal['imageUrl'] != null
                                    ? Image.network(
                                      meal['imageUrl'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                    : Icon(Icons.fastfood),
                            title: Text(
                              meal['foodCombination'] ?? 'No Name Provided',
                            ),
                            subtitle: Text('Price: ₦${meal['price'] ?? '0'}'),
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


/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'health_rating_screen.dart';

class HomeScreennn extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreennn> {
  List<dynamic> mealRecommendations = [];
  bool isLoading = false;
  TextEditingController _budgetController = TextEditingController();

  // ✅ Dynamically get API base URL based on platform
  String getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080'; // For Android emulator
    } else if (Platform.isIOS) {
      return 'http://localhost:8080'; // For iOS simulator
    } else {
      throw UnsupportedError("Platform not supported");
    }
  }

  // ✅ Fetch meal recommendations using POST request
  Future<void> fetchMealRecommendations(String budget) async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl = '${getBaseUrl()}/api/recommend';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"budget": int.parse(budget)}), // Send budget as JSON
      );

      if (response.statusCode == 200) {
        setState(() {
          mealRecommendations = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch recommendations')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // ✅ UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NutriBudget'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.pink.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Set Your Budget',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
                    child: Text(
                      'Get Meal Suggestions',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: mealRecommendations.length,
                      itemBuilder: (context, index) {
                        final meal = mealRecommendations[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HealthRatingScreen(meal: meal),
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
                            title:
                            Text(meal['foodItem'] ?? 'No Name Provided'),
                            subtitle: Text(
                                'Price: ₦${meal['price'] ?? '0'}\nCalories: ${meal['calories'] ?? 'N/A'}'),
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
}*/


/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'health_rating_screen.dart';

class HomeScreennn extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreennn> {
  List<dynamic> mealRecommendations = [];
  bool isLoading = false;
  TextEditingController _budgetController = TextEditingController();

  // ✅ Dynamically get API base URL based on platform
  String getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080';  // For Android emulator
    } else if (Platform.isIOS) {
      return 'http://localhost:8080';  // For iOS simulator
    } else {
      throw UnsupportedError("Platform not supported");
    }
  }

  // ✅ Fetch meal recommendations using just http.Response
  Future<void> fetchMealRecommendations(String budget) async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl = '${getBaseUrl()}/api/recommend?budget=$budget';  // GET request with query parameter

    try {
      // Fetching the response from the backend
      final http.Response response = await http.get(Uri.parse(apiUrl));  // The response is of type http.Response

      // Debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parsing the JSON response into a List of meals
        setState(() {
          mealRecommendations = json.decode(response.body);  // Decode the response body to a list of meals
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch recommendations')),
        );
      }
    } catch (e) {
      print('Error: $e'); // For debugging
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NutriBudget'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.pink.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Set Your Budget',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
                    child: Text(
                      'Get Meal Suggestions',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: mealRecommendations.length,
                      itemBuilder: (context, index) {
                        final meal = mealRecommendations[index];
                        return Card(
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
                            title: Text(meal['foodItem'] ?? 'No Name Provided'),
                            subtitle: Text(
                                'Price: ₦${meal['price'] ?? '0'}\nCalories: ${meal['calories'] ?? 'N/A'}'),
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
}*/


