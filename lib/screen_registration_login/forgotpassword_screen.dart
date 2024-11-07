import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_maker/screen_registration_login/verification_screen.dart';
import '../Helper/custom_colors.dart';

class forgotpass_screen extends StatefulWidget {
  const forgotpass_screen({super.key});

  @override
  State<forgotpass_screen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<forgotpass_screen> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_clearEmailError);
  }

  void _clearEmailError() {
    setState(() {
      _emailError = null;
    });
  }

  bool _isValidEmail(String email) {
    // Simple email validation regex
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _sendCode() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please enter an email.';
      });
    } else if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Please enter a valid email.';
      });
    } else {
      // Navigate to the verification screen
      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return verification();
          }));
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_clearEmailError);
    _emailController.dispose();
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
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please enter your email to receive a reset code',
                        style: TextStyle(
                          fontSize: 16.0,
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
                    Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        filled: true,
                        fillColor: Color(0xFFF0F5FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: _emailError,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.0),
                    // Send Code Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _sendCode,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: CustomColors.primaryColor,
                        ),
                        child: Text(
                          'Send Code',
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
}
