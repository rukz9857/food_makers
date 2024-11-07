import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/custom_colors.dart';
import 'login_screen.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<registration> {
  // Controllers for text input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();

  // Error messages for each field
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _retypePasswordError;

  // Password visibility states
  bool _isPasswordVisible = false;
  bool _isRetypePasswordVisible = false;

  @override
  void initState() {
    super.initState();

    // Add listeners to clear errors when the user starts typing
    _nameController.addListener(() {
      if (_nameError != null && _nameController.text.isNotEmpty) {
        setState(() {
          _nameError = null;
        });
      }
    });
    _emailController.addListener(() {
      if (_emailError != null && _emailController.text.isNotEmpty) {
        setState(() {
          _emailError = null;
        });
      }
    });
    _passwordController.addListener(() {
      if (_passwordError != null && _passwordController.text.isNotEmpty) {
        setState(() {
          _passwordError = null;
        });
      }
    });
    _retypePasswordController.addListener(() {
      if (_retypePasswordError != null && _retypePasswordController.text.isNotEmpty) {
        setState(() {
          _retypePasswordError = null;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose the controllers to free resources
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleRetypePasswordVisibility() {
    setState(() {
      _isRetypePasswordVisible = !_isRetypePasswordVisible;
    });
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
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please sign up for a new account',
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

            // Sign-up form
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
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                        filled: true,
                        fillColor: Color(0xFFF0F5FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: _nameError,
                      ),
                    ),
                    SizedBox(height: 16.0),

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
                    ),
                    SizedBox(height: 16.0),

                    Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        filled: true,
                        fillColor: Color(0xFFF0F5FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        errorText: _passwordError,
                      ),
                    ),
                    SizedBox(height: 16.0),

                    Text(
                      'Re-type Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _retypePasswordController,
                      obscureText: !_isRetypePasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Re-enter Password',
                        filled: true,
                        fillColor: Color(0xFFF0F5FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isRetypePasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _toggleRetypePasswordVisibility,
                        ),
                        errorText: _retypePasswordError,
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _validateAndSubmit,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: CustomColors.primaryColor,
                        ),
                        child: Text(
                          'Sign Up',
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

  // Function to validate the input fields and passwords
  void _validateAndSubmit() async {
    setState(() {
      _nameError = _emailError = _passwordError = _retypePasswordError = null;
    });

    // Check if all fields are filled
    bool hasError = false;
    String emailPattern = r'^[^@]+@[^@]+\.[^@]+$';  // Basic email validation pattern
    RegExp regExp = RegExp(emailPattern);

    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = 'Name is required.';
      });
      hasError = true;
    }
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Email is required.';
      });
      hasError = true;
    } else if (!regExp.hasMatch(_emailController.text)) {
      setState(() {
        _emailError = 'Please enter a valid email address.';
      });
      hasError = true;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password is required.';
      });
      hasError = true;
    }
    if (_retypePasswordController.text.isEmpty) {
      setState(() {
        _retypePasswordError = 'Please re-enter your password.';
      });
      hasError = true;
    }

    // Check if passwords match
    if (_passwordController.text != _retypePasswordController.text) {
      setState(() {
        _retypePasswordError = 'Passwords do not match.';
      });
      hasError = true;
    }

    // If no errors, proceed to save the data or perform sign-up logic
    if (!hasError) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
