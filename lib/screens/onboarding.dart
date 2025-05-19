import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

/*class LunchTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Carousel
            /*SizedBox(
              height: 250, // Adjust height based on the image size
              child: PageView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0), // Match the top-right corner
                      bottomRight: Radius.circular(12.0), // Match the bottom-right corner
                    ),
                    child: Image.asset(
                      'images/Img2.png',
                      fit: BoxFit.cover,

                      // Replace with your image asset
                      //fit: BoxFit.cover,
                    ),
                  ),
                  Image.asset(
                    'images/Img1.png', // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),*/
          SizedBox(
          height: 250, // Adjust height based on the image size
          child: PageView.builder(
    controller: _pageController,
    itemCount: 2, // Number of images
    itemBuilder: (context, index) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(12.0), // Rounded corners
    child: Image.asset(
    index == 0
    ? 'assets/lunch1.jpg' // Replace with your first image asset
        : 'assets/lunch2.jpg', // Replace with your second image asset
    fit: BoxFit.cover,
    ),
            // Spacer between the carousel and the text
            SizedBox(height: 20),

            // Headline Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Enjoy your lunch time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Description Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                'Just relax and not overthink what to eat. This is in our side with our personalized meal plans just prepared and adapted to your needs.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),

            // Spacer between the text and the footer
            Spacer(),

            // Footer with page indicator and button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicator
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pink, // Active indicator
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey, // Inactive indicator
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey, // Inactive indicator
                        ),
                      ),
                    ],
                  ),

                  // Next Button
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation or action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Button color
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LunchTimeScreen(),
  ));
}*/
import 'package:flutter/material.dart';

class LunchTimeScreen extends StatefulWidget {
  const LunchTimeScreen({super.key});

  @override
  _LunchTimeScreenState createState() => _LunchTimeScreenState();
}

class _LunchTimeScreenState extends State<LunchTimeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Carousel with Overlap
            SizedBox(
              height: 250, // Adjust height based on the image size
              child: PageView.builder(
                controller: _pageController,
                itemCount: 2, // Number of images
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          12.0,
                        ), // Match the top-right corner
                        bottomRight: Radius.circular(
                          12.0,
                        ), // Match the bottom-right corner
                      ),
                      child: Image.asset(
                        index == 0
                            ? 'images/Img2.png' // Replace with your first image asset
                            : 'images/Img1.png', // Replace with your second image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Spacer between the carousel and the text
            SizedBox(height: 20),

            // Headline Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Enjoy your lunch time',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            // Description Text
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 19.0,
                vertical: 27.0,
              ),
              child: Text(
                'Just relax and not overthink what to eat. This is in our side with our personalized meal plans just prepared and adapted to your needs.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),

            // Spacer between the text and the footer
            Spacer(),

            // Footer with page indicator and button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicator
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green, // Active indicator
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey, // Inactive indicator
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey, // Inactive indicator
                        ),
                      ),
                    ],
                  ),

                  // Next Button
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation or action here
                      Navigator.pushNamed(context, '/fourth');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Button color
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: LunchTimeScreen()),
  );
}
