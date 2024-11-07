import 'package:flutter/material.dart';

class PizzaOrderItem extends StatefulWidget {
  final String name;
  final String type;
  final double price;
  final String size;
  int quantity; // Mutable quantity
  final String imageUrl;
  final VoidCallback onRemove; // Callback to remove item

  PizzaOrderItem({
    required this.name,
    required this.type,
    required this.price,
    required this.size,
    required this.quantity,
    required this.imageUrl,
    required this.onRemove, // Required parameter for onRemove
  });

  @override
  _PizzaOrderItemState createState() => _PizzaOrderItemState();
}

class _PizzaOrderItemState extends State<PizzaOrderItem> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    } else {
      widget.onRemove(); // Call the onRemove callback when quantity reaches zero
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image for pizza
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          // Pizza details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(widget.type, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                SizedBox(height: 8),
                Text('\$${widget.price}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(widget.size, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                SizedBox(height: 8),
              ],
            ),
          ),
          // Quantity buttons
          Row(
            children: [
              IconButton(
                onPressed: _decrementQuantity,
                icon: Icon(Icons.remove_circle_outline),
                color: Colors.black,
              ),
              Text(
                _quantity.toString(),
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              IconButton(
                onPressed: _incrementQuantity,
                icon: Icon(Icons.add_circle_outline),
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
