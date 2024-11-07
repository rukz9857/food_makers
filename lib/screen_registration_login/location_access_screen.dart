import 'package:flutter/material.dart';
import 'package:food_maker/main_screen/home_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer; // Use this for logging

import '../Helper/custom_colors.dart';

class location_access extends StatefulWidget {
  const location_access({Key? key}) : super(key: key);

  @override
  State<location_access> createState() => _LocationAccessState();
}

class _LocationAccessState extends State<location_access> {

  @override
  void initState() {
    super.initState();
    // Check and handle location permission when the widget is first created
    checkAndNavigate();
  }

  // Method to check location permission and navigate accordingly
  Future<void> checkAndNavigate() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // Permission already granted, navigate to home screen
      navigateToHome();
    } else {
      // Request permission if not granted
      await getCurrentLocation();
    }
  }

  // Method to request location permission and get the current location
  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // If permission is granted, get the location and navigate to home screen
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      // Log the latitude and longitude
      developer.log("Latitude: ${currentPosition.latitude}", name: 'Location Access');
      developer.log("Longitude: ${currentPosition.longitude}", name: 'Location Access');

      // Navigate to the home screen
      navigateToHome();
    }
  }

  // Method to navigate to the home screen
  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Placeholder for the rounded image
              Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0), // Ensures the image respects the container's rounded corners
                  child: Image.asset(
                    'assets/images/location.png', // Replace with your image path
                    fit: BoxFit.cover, // Adjust to fit the container
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              // Access Location Button
              ElevatedButton.icon(
                onPressed: getCurrentLocation, // Call getCurrentLocation if button is pressed manually
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  backgroundColor: CustomColors.primaryColor, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                icon: const Icon(Icons.location_pin, color: Colors.white),
                label: const Text(
                  'ACCESS LOCATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Footer text
              const Text(
                'DFOOD WILL ACCESS YOUR LOCATION\nONLY WHILE USING THE APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
