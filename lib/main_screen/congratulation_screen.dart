import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/custom_colors.dart'; // Add this for using Material widgets like ElevatedButton

class ConratulationScreen extends StatefulWidget {
  const ConratulationScreen({super.key});

  @override
  State<ConratulationScreen> createState() => _ConratulationScreenState();
}

class _ConratulationScreenState extends State<ConratulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for the image or icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[400], // Placeholder color
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 30), // Space between the image and text

              // Congratulations Text
              Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10), // Space between texts

              // Subtext
              Text(
                'You successfully made a payment, \nenjoy our service!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40), // Space before the button

              // Track Order Button
              ElevatedButton(
                onPressed: () {
                  // Add your action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor, // Button background color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'TRACK ORDER',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
