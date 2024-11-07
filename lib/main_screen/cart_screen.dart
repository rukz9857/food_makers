import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/custom_colors.dart';
import 'home_screen.dart';
import 'payment_screen.dart'; // Make sure to import the PaymentScreen

class CartScreen extends StatefulWidget {
  final String name;
  final double price;
  final String imagePath;

  const CartScreen({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1; // To keep track of the item quantity
  List<Map<String, dynamic>> cartItems = []; // To store cart items

  @override
  void initState() {
    super.initState();
    _loadInitialQuantity();
  }

  Future<void> _loadInitialQuantity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedQuantity = prefs.getInt('quantity_cart');

    // Update the quantity and cartItems if there's a saved quantity
    if (savedQuantity != null) {
      setState(() {
        quantity = savedQuantity;
        // Add or update the cartItems list as needed
        _updateCartItem(widget.name, quantity);
      });
    }
  }

  Future<void> _saveQuantityToSharedPreferences(int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quantity_cart2', quantity);
  }

  void _updateCartItem(String name, int newQuantity) {
    setState(() {
      Map<String, dynamic> item = {
        'name': name,
        'price': widget.price,
        'imagePath': widget.imagePath,
        'quantity': newQuantity,
      };
      if (newQuantity == 0) {
        cartItems.removeWhere((item) => item['name'] == name);
      } else {
        int index = cartItems.indexWhere((item) => item['name'] == name);
        if (index >= 0) {
          cartItems[index] = item;
        } else {
          cartItems.add(item);
        }
      }
      _saveQuantityToSharedPreferences(newQuantity);
    });
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
      _updateCartItem(widget.name, quantity);
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        _updateCartItem(widget.name, quantity);
      });
    } else if (quantity == 1) {
      setState(() {
        quantity = 0;
        _updateCartItem(widget.name, quantity);
      });
    }
  }

  double calculateTotalPrice() {
    return widget.price * quantity;
  }

  void _showCheckoutBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 50,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                    widget.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rs ${calculateTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Checkout',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>HomeScreen()
              ),
            );
          },
        ),
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: quantity > 0
          ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          widget.imagePath,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Rs ${widget.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: _decreaseQuantity,
                                    icon: Icon(Icons.remove_circle_outline),
                                  ),
                                  Text(
                                    '$quantity',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _increaseQuantity,
                                    icon: Icon(Icons.add_circle_outline),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rs ${calculateTotalPrice().toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _showCheckoutBottomSheet,
                child: Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cart.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Cart is empty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
