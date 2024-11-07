import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main_screen/fooditem_screen.dart'; // Assuming the next screen is called `fooditem_screen.dart`

class CategoryCard extends StatelessWidget {
  final String name;
  final double price;
  final String imagePath;

  const CategoryCard({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Pass the name, price, and imagePath to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodItemScreen(
              name: name,
              price: price,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        width: 200.0,
        height: 250.0,
        margin: EdgeInsets.only(right: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Starting \$$price',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
