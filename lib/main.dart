import 'package:flutter/material.dart';
import 'package:food_maker/splash_screen.dart';

import 'Helper/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: ThemeData(
        fontFamily: 'Fonts',
        primaryColor: CustomColors.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColors.primaryColor,
        ),
        scaffoldBackgroundColor: CustomColors.backgrounColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: CustomColors.primaryColor, // Set your desired cursor color here
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF0F5FA), // Set the background color for TextField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.primaryColor, // Set your desired focus border color here
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primaryColor, // Set global button background color
            foregroundColor: Colors.white,  // Set global button text color
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: CustomColors.primaryColor, // Set global text button color
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: CustomColors.primaryColor , // Set global outlined button color
          ),
        ),
        useMaterial3: true,
      ),

      home: const splash_screen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: const TextStyle(fontFamily: 'Fonts'),),
      ),
      body:Container(),
    );
  }
}
