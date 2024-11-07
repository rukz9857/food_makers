import 'package:flutter/material.dart';
import 'package:food_maker/main_screen/home_screen.dart'; // Import the HomeScreen
import 'package:food_maker/screen_registration_login/login_screen.dart'; // Import the LoginScreen

import '../Helper/custom_colors.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/images/image_1.jpg',
      'title': "All your favorites",
      'subtitle': "Get all your loved foods in one place, you just place the order we do the rest",
    },
    {
      'image': 'assets/images/image_2.jpeg',
      'title': "Order from chosen chef",
      'subtitle': "Get all your loved foods in one place, you just place the order we do the rest",
    },
    {
      'image': 'assets/images/image_3.jpg',
      'title': "Free delivery offers",
      'subtitle': "Get all your loved foods in one place, you just place the order we do the rest",
    },
    // Add more pages as needed
  ];

  void _nextPage() {
    setState(() {
      if (_currentIndex < _pages.length - 1) {
        _currentIndex++;
      } else {
        // Navigate to the home screen when the last page is reached
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image/Illustration at the top
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Container(
                  height: 300, // Adjust height as necessary
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Placeholder color if the image fails to load
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Match the border radius
                    child: Image.asset(
                      page['image'], // Replace with your image path
                      fit: BoxFit.cover, // Adjust the image fit as necessary
                    ),
                  ),
                ),
              ),
            ),
            // Title
            Text(
              page['title'],
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Subtitle/Description
            Text(
              page['subtitle'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),

            // Page Indicator (Dots)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => _buildDot(index == _currentIndex),
              ),
            ),

            // Next button and Skip text
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50, // Adjust button height
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _nextPage,
                    child: Text(
                      _currentIndex == _pages.length - 1 ? 'Continue' : 'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Dot indicator builder
  Widget _buildDot(bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: isActive ? CustomColors.primaryColor : Colors.grey[300],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
