import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_maker/Helper/custom_colors.dart';
import 'package:food_maker/main_screen/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodItemScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final double price;

  const FoodItemScreen({
    super.key,
    required this.name,
    required this.imagePath,
    required this.price,
  });

  @override
  State<FoodItemScreen> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItemScreen> {
  int quantity = 1;
  String selectedSize = '14"'; // Default selected size

  void _onSizeSelected(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgrounColor,
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image and Icons
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // Restaurant Info and Product Title
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.store, color: CustomColors.primaryColor),
                        SizedBox(width: 10.0),
                        Text(
                          'Uttora Coffee House',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Delicious pizza with fresh ingredients.',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // Rating, Delivery Fee, Time
                  Row(
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
                          Icon(Icons.access_time_outlined,
                              color: CustomColors.primaryColor),
                          Text('20 min'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text('SIZE : ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 200,
                        child: Row(
                          children: [
                            PizzaSizeButton(
                                size: '10"',
                                isSelected: selectedSize == '10"',
                                onSelected: _onSizeSelected),
                            PizzaSizeButton(
                                size: '14"',
                                isSelected: selectedSize == '14"',
                                onSelected: _onSizeSelected),
                            PizzaSizeButton(
                                size: '16"',
                                isSelected: selectedSize == '16"',
                                onSelected: _onSizeSelected),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  // Ingredients
                  Text('INGREDIENTS', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IngredientIcon(icon: Icons.local_pizza),
                      IngredientIcon(icon: Icons.grass),
                      IngredientIcon(icon: Icons.local_fire_department),
                      IngredientIcon(icon: Icons.food_bank),
                      IngredientIcon(icon: Icons.local_dining),
                    ],
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${widget.price}',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold)),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF121223),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.remove_circle, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                              ),
                              Text(
                                quantity.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                color: Colors.grey,
                                icon: Icon(Icons.add_circle, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await _saveQuantityToSharedPreferences(quantity); // Save quantity
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(
                                name: widget.name,
                                price: widget.price,
                                imagePath: widget.imagePath,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: CustomColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
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
    );
  }
}

Future<void> _saveQuantityToSharedPreferences(int quantity) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('quantity_cart', quantity);
}

class PizzaSizeButton extends StatelessWidget {
  final String size;
  final bool isSelected;
  final ValueChanged<String> onSelected;

  const PizzaSizeButton({
    required this.size,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(size),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.primaryColor : Color(0xFFF0F5FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class IngredientIcon extends StatelessWidget {
  final IconData icon;

  const IngredientIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFEBE4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: CustomColors.primaryColor),
    );
  }
}
