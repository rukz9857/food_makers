import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_maker/walkThroughScreen/on_boarding.dart';
import 'main.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splash_screen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationTopLeft;
  late Animation<Offset> _animationBottomRight;

  @override
  void initState() {
    super.initState();

    // Timer for navigating to the next screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return OnBoardingScreen();
      }));
    });

    // Initialize animation controller and animations for sliding
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Slide animation from top-left (-1.0, -1.0) to original position (0.0, 0.0)
    _animationTopLeft = Tween<Offset>(
      begin: Offset(-1.0, -1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Slide animation from bottom-right (1.0, 1.0) to original position (0.0, 0.0)
    _animationBottomRight = Tween<Offset>(
      begin: Offset(1.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Sliding image from top-left corner
          SlideTransition(
            position: _animationTopLeft,
            child: Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                'assets/svgs/animation_image2.svg',
                width: 200, // Adjust size as necessary
                height: 200,
              ),
            ),
          ),

          // Sliding image from bottom-right corner
          SlideTransition(
            position: _animationBottomRight,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                'assets/svgs/animation_image1.svg',
                width: 200, // Adjust size as necessary
                height: 200,
              ),
            ),
          ),

          // Centered logo
          Center(
            child: SvgPicture.asset(
              'assets/svgs/logo.svg',
              width: 150, // Adjust logo size as necessary
            ),
          ),
        ],
      ),

    );
  }
}
