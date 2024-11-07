import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main_screen/restaurentmenu_screen.dart'; // Import flutter_svg package

class Cart extends StatelessWidget {
  final String title;
  final String description;
  final double rating;
  final String deliveryFee;
  final String time;
  final String imgAsset;  // Reference to the SVG file

  const Cart({
    Key? key,
    required this.title,
    required this.description,
    required this.rating,
    required this.deliveryFee,
    required this.time,
    required this.imgAsset,  // Reference to the SVG file
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => restaurant_item(),
            ));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Replaced Network Image with SVG from Assets
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                imgAsset,  // Load SVG file from assets
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(rating.toString()),
                      const SizedBox(width: 10.0),
                      const Icon(Icons.delivery_dining, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(deliveryFee),
                      const SizedBox(width: 10.0),
                      const Icon(Icons.access_time, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(time),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
