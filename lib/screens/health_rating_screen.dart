import 'package:flutter/material.dart';

class HealthRatingScreen extends StatelessWidget {
  final Map<String, dynamic> meal; // Meal data passed from the previous screen

  const HealthRatingScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    // Calculate health score classification
    final int healthClassification =
        int.tryParse(meal['healthScore'].toString()) ?? -1;

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(meal['foodCombination'] ?? 'Health Rating'),
        backgroundColor: Colors.pink[50],
      ),
      body: Container(
        width: double.infinity, // Ensures the container takes up the full width
        height:
            double.infinity, // Ensures the container takes up the full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade50, // Start color
              Colors.white, // End color
            ],
            begin: Alignment.topLeft, // Gradient starting point
            end: Alignment.bottomRight, // Gradient ending point
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal Image
              if (meal['imageUrl'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    meal['imageUrl'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),

              // Health Classification
              Text(
                'Health Classification: $healthClassification',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Health Score Explanation
              if (healthClassification >= 8 && healthClassification < 11)
                Text(
                  'This meal is classified as healthy based on its ingredients!',
                  style: TextStyle(fontSize: 16),
                )
              else if (healthClassification >= 5 && healthClassification < 8)
                Text(
                  'This meal is classified as moderate.',
                  style: TextStyle(fontSize: 16),
                )
              else if (healthClassification >= 0 && healthClassification < 5)
                Text(
                  'This meal is classified as unhealthy.',
                  style: TextStyle(fontSize: 16),
                )
              else
                Text(
                  'Health rating information is not available for this meal.',
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
