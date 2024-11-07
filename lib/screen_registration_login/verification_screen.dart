import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_maker/screen_registration_login/login_screen.dart';

import '../Helper/custom_colors.dart';

class verification extends StatefulWidget {
  const verification({super.key});

  @override
  State<verification> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<verification> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index < _focusNodes.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  bool _areAllOtpBoxesFilled() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background_screen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top space or decorative elements
            Container(
              height: 250.0,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: [
                      Text(
                        'Verification',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please sign in to your existing account',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        'example@gmail.com',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text(
                          'Code',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Resend',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) => _buildOtpBox(index)),
                      ),
                    ),

                    SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_areAllOtpBoxesFilled()) {
                            // Navigate to the LoginScreen if all OTP boxes are filled
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return LoginScreen();
                                }));
                          } else {
                            // Show an error message if not all OTP boxes are filled
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter the complete OTP.',style: TextStyle(color: Colors.white),),
                                backgroundColor: CustomColors.primaryColor,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: CustomColors.primaryColor,
                        ),
                        child: Text(
                          'Verify Code',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFF0F5FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: "", // Hide the counter
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) => _onChanged(value, index),
        ),
      ),
    );
  }
}
