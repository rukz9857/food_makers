import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_maker/Helper/custom_colors.dart';
import 'package:food_maker/drawer_screen/order_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_maker/main_screen/cart_screen.dart';
import '../Helper/assets.dart';
import '../Helper/cart_item_horizontal.dart';
import '../Helper/cart_item_vertical.dart';
import '../drawer_screen/address_screen.dart';
import '../drawer_screen/personal_info.dart';
import '../screen_registration_login/login_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLocation = 'Halal Lab office'; // Default value
  List<String> locations = [
    'Halal Lab office',
    'Home',
    'Office 2'
  ]; // Drop-down options
  late int quantity;
  String? userName; // To store the user name

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  // Retrieve quantity from SharedPreferences
  Future<void> _getQuantityFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      quantity = prefs.getInt('quantity_cart2') ?? 0; // Fallback to 0 if not found
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getQuantityFromSharedPreferences(); // Refresh cart count when dependencies change
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name'); // Provide a default value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgrounColor,
        elevation: 0,
        toolbarHeight: 80,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: SvgPicture.asset(Assets.menuIcon),
            // Path to your SVG icon
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer when clicked
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text(
              'DELIVER TO',
              style: TextStyle(fontSize: 12.0, color: Colors.orange),
            ),
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedLocation,
                  // The current selected value
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  // The drop-down arrow icon
                  items: locations.map((String location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(
                        location,
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocation = newValue!;
                    });
                  },
                  underline: Container(),
                  // Remove the default underline
                  style: TextStyle(color: Colors.black),
                  // Text color of selected item
                  dropdownColor:
                      Colors.white, // Background color of the drop-down
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_bag_outlined,
                    color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        name: '', // Provide a default or pass data if needed
                        price: 0.0, // Provide a default or pass data if needed
                        imagePath: '', // Provide a default or pass data if needed
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting and Search Box
              Text(
                'Hey Halal, Good Afternoon!',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search dishes, restaurants',
                        prefixIcon: Icon(Icons.search,
                            color: CustomColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // All Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Categories',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 14.0, color: CustomColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                height: 200.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCard(
                      name: 'Pizza',
                      price: 70,
                      imagePath: "assets/images/pizza.jpg",
                    ),
                    CategoryCard(
                      name: 'Pizza',
                      price: 20,
                      imagePath: "assets/images/pizza.jpg",
                    ),
                    CategoryCard(
                      name: 'Pizza',
                      price: 80,
                      imagePath: "assets/images/pizza.jpg",
                    ),
                    CategoryCard(
                      name: 'Pizza',
                      price: 70,
                      imagePath: "assets/images/pizza.jpg",
                    ),
                    CategoryCard(
                      name: 'Burger',
                      price: 50,
                      imagePath: "assets/images/pizza.jpg",
                    ),
                    CategoryCard(
                      name: 'Pasta',
                      price: 60,
                      imagePath: "assets/images/pizza.jpg",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              // Open Restaurants Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Open Restaurants',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        fontSize: 14.0, color: CustomColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              // Open Restaurant Card
              ListView(
                shrinkWrap: true,
                // Shrink the list view to fit within the available space
                physics: NeverScrollableScrollPhysics(),
                // Disable scrolling for the ListView
                children: [
                  Cart(
                    title: 'Rose Garden Restaurant',
                    description: 'Burger - Chicken - Rice - Wings',
                    rating: 4.7,
                    deliveryFee: 'Free',
                    time: '20 min',
                    imgAsset: 'assets/images/restaurant_image1.jpg',
                  ),
                  Cart(
                    title: 'Ocean Breeze Cafe',
                    description: 'Pizza - Salad - Coffee',
                    rating: 4.5,
                    deliveryFee: '\$5',
                    time: '30 min',
                    imgAsset: 'assets/images/restaurant_image2.jpeg',
                  ),
                  Cart(
                    title: 'Mountain Breeze Cafe',
                    description: 'Pizza - Salad - Coffee',
                    rating: 3.5,
                    deliveryFee: '\$5',
                    time: '1 hour',
                    imgAsset: 'assets/images/restaurant_image3.jpeg',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.orange.shade100,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName ?? 'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'I love fast food',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Personal Info'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PersonalInfoScreen();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Addresses'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyAddressScreen();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_outlined),
              title: Text('Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      name: '', // Provide a default or pass data if needed
                      price: 0.0, // Provide a default or pass data if needed
                      imagePath: '', // Provide a default or pass data if needed
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text('Favourite'),
              onTap: () {
                // Action for favourites
              },
            ),
            ListTile(
              leading: Icon(Icons.card_travel),
              title: Text('My Orders'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OrderScreen();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_outlined),
              title: Text('Notifications'),
              onTap: () {
                // Action for notifications
              },
            ),
            ListTile(
              leading: Icon(Icons.payment_outlined),
              title: Text('Payment Method'),
              onTap: () {
                // Action for payment method
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('FAQs'),
              onTap: () {
                // Action for FAQs
              },
            ),
            ListTile(
              leading: Icon(Icons.star_outline),
              title: Text('User Reviews'),
              onTap: () {
                // Action for user reviews
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Settings'),
              onTap: () {
                // Action for settings
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('name');
                await prefs.remove('email');
                await prefs.remove('password');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
