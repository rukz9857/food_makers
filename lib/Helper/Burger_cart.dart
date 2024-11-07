import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_colors.dart';

class BurgerCard extends StatelessWidget {
  final String name;
  final String restaurant;
  final int price;

  const BurgerCard({required this.name, required this.restaurant, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 10),
            // Burger Name and Restaurant
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              restaurant,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            // Price and Add to Cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: CustomColors.primaryColor),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}