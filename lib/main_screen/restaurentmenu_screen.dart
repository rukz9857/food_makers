import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Helper/cart_item_horizontal.dart';
import '../Helper/custom_colors.dart';
import 'fooditem_screen.dart'; // Assuming your CategoryCard is in a separate file

class restaurant_item extends StatefulWidget {
  @override
  _RestaurantItemState createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<restaurant_item> {
  String selectedCategory = 'Burger';
  List<String> categories = ['Burger', 'Sandwich', 'Pizza', 'Momos'];

  final List<Map<String, dynamic>> categoryItems = [
    {'name': 'Fruits', 'price': 10.0, 'imagePath': "assets/images/pizza.jpg"},
    {'name': 'Vegetables', 'price': 5.0, 'imagePath': "assets/images/pizza.jpg"},
    {'name': 'Dairy', 'price': 8.0, 'imagePath': "assets/images/pizza.jpg"},
    // Add more categories here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Restaurant View',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image and Info
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/restaurant_image1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Restaurant Name and Description
            Text(
              'Spicy Restaurant',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              'Maecenas sed diam eget risus varius blandit sit amet non magna.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 20.0),

            // Rating, Free Delivery, and Time
            Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_border, color: Colors.orange, size: 20),
                      Text('4.7'),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/truck.svg',
                        height: 15.0,
                        width: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text('Free', style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, color: CustomColors.primaryColor),
                      Text('20 min'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            // Category Tabs
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ChoiceChip(
                      checkmarkColor: selectedCategory == categories[index] ? Colors.white : Colors.black,
                      label: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategory == categories[index] ? Colors.white : Colors.black,
                        ),
                      ),
                      selected: selectedCategory == categories[index],
                      selectedColor: CustomColors.primaryColor,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = categories[index];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),

            // List of Category Items
            Text(
              '$selectedCategory (10)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),

            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 0.80,
              ),
              itemCount: categoryItems.length,
              itemBuilder: (context, index) {
                final category = categoryItems[index];
                return CategoryCard(
                  name: category['name']!,
                  price: category['price'] as double,
                  imagePath: category['imagePath']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
