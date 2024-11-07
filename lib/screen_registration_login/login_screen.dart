import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_maker/screen_registration_login/registration_screen.dart';
import '../Helper/custom_colors.dart';
import 'forgotpassword_screen.dart';
import 'location_access_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;
  bool _isPasswordVisible = false;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_clearErrors);
    _passwordController.addListener(_clearErrors);
  }

  void _clearErrors() {
    if (_emailController.text.isNotEmpty) {
      setState(() {
        _emailError = null;
      });
    }
    if (_passwordController.text.isNotEmpty) {
      setState(() {
        _passwordError = null;
      });
    }
  }

  // Function to validate and check credentials from shared preferences
  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    String enteredEmail = _emailController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (enteredEmail.isEmpty && enteredPassword.isEmpty) {
      setState(() {
        _emailError = 'Please enter both email and password.';
        _passwordError = 'Please enter both email and password.';
      });
    } else if (enteredEmail.isEmpty) {
      setState(() {
        _emailError = 'Please enter an email.';
      });
    } else if (enteredPassword.isEmpty) {
      setState(() {
        _passwordError = 'Please enter a password.';
      });
    } else if (enteredEmail != savedEmail) {
      setState(() {
        _emailError = 'Incorrect email.';
      });
    } else if (enteredPassword != savedPassword) {
      setState(() {
        _passwordError = 'Incorrect password.';
      });
    } else {
      // Reset errors and navigate to the next screen
      setState(() {
        _emailError = null;
        _passwordError = null;
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return location_access();
          }));
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_clearErrors);
    _passwordController.removeListener(_clearErrors);
    _emailController.dispose();
    _passwordController.dispose();
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
                        'Log In',
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
                    ],
                  ),
                ),
              ),
            ),

            // Email field
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
                      'EMAIL',
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
                    ),
                    SizedBox(height: 16.0),

                    // Password field
                    Text(
                      'PASSWORD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible, // toggle obscureText based on the state
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        filled: true,
                        fillColor: Color(0xFFF0F5FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility // Show the "eye" icon when visible
                                : Icons.visibility_off, // Show "eye_off" icon when not visible
                          ),
                          onPressed: () {
                            // Toggle password visibility
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        errorText: _passwordError,
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Remember me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked, // Bind the checkbox value to _isChecked
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false; // Update the state
                                });
                              },
                              activeColor: CustomColors.primaryColor,
                            ),
                            Text('Remember me'),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return forgotpass_screen();
                                }));
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Log In Button
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _checkLogin(); // Check credentials and navigate if valid
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: CustomColors.primaryColor,
                        ),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Sign up option
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return registration();
                                }));
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // OR separator
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Or'),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),

                    // Social media buttons
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialButton(Icons.facebook, Colors.blue[800]!),
                        _socialButton(Icons.apple, Colors.black),
                        _socialButton(Icons.alternate_email, Colors.lightBlue),
                      ],
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

  Widget _socialButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 24.0,
      backgroundColor: color,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

