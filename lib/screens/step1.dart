import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class IngredientAllergiesScreen extends StatefulWidget {
  @override
  _IngredientAllergiesScreenState createState() =>
      _IngredientAllergiesScreenState();
}

class _IngredientAllergiesScreenState extends State<IngredientAllergiesScreen> {
  List<String> allergies = [
    'Gluten',
    'Diary',
    'Egg',
    'Soy',
    'Peanut',
    'Wheat',
    'Milk',
    'Fish',
  ];

  List<String> selectedAllergies = [];

  void toggleSelection(String allergy) {
    setState(() {
      if (selectedAllergies.contains(allergy)) {
        selectedAllergies.remove(allergy);
      } else {
        selectedAllergies.add(allergy);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              // Add skip functionality here
              Navigator.pushNamed(context, '/fourth');
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor:
                    index == 1 ? Colors.pink : Colors.grey.shade300,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: index == 1 ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 24),

            // Question Title
            Text(
              'Any ingredient allergies?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'To offer you the best tailored diet experience we need to know more information about you.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24),

            // Allergy Chips
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: allergies.map((allergy) {
                bool isSelected = selectedAllergies.contains(allergy);
                return ChoiceChip(
                  label: Text(allergy),
                  selected: isSelected,
                  onSelected: (selected) {
                    toggleSelection(allergy);
                  },
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: Colors.pink,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            Spacer(),


            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Button
                OutlinedButton(
                  onPressed: () {
                    // Add previous functionality here
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey),
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                  child: Text(
                    'Previous',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Next Button
                ElevatedButton(
                  onPressed: () {
                    // Add next functionality here
                    Navigator.pushNamed(context, '/third');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: IngredientAllergiesScreen(),
  ));
}