import 'package:flutter/material.dart';
import 'package:food_maker/Helper/custom_colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgrounColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: CustomColors.primaryColor,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Ongoing'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderListView(
            orders: ongoingOrders,
            showTrackOrder: true,
          ),
          OrderListView(
            orders: historyOrders,
            showTrackOrder: false,
          ),
        ],
      ),
    );
  }
}

class OrderListView extends StatelessWidget {
  final List<Order> orders;
  final bool showTrackOrder;

  const OrderListView({required this.orders, required this.showTrackOrder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: orders[index], showTrackOrder: showTrackOrder);
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final bool showTrackOrder;

  const OrderCard({required this.order, required this.showTrackOrder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.restaurantName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(order.orderId,
                    style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 4),
            Text("\$${order.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16, color: CustomColors.primaryColor)),
            const SizedBox(height: 4),
            Text("${order.items} items",
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 16),
            if (showTrackOrder)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white),
                    child: const Text('Track Order'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: CustomColors.primaryColor)),
                    child: Text('Cancel',
                        style: TextStyle(color: CustomColors.primaryColor)),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        order.status,
                        style: TextStyle(
                            color: order.status == 'Completed'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(order.date,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: CustomColors.primaryColor)),
                        child: Text('Rate',
                            style: TextStyle(color: CustomColors.primaryColor)),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.primaryColor,
                            foregroundColor: Colors.white),
                        child: const Text('Re-Order'),
                      ),
                    ],
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Order {
  final String restaurantName;
  final double price;
  final int items;
  final String orderId;
  final String status;
  final String date;

  Order({
    required this.restaurantName,
    required this.price,
    required this.items,
    required this.orderId,
    required this.status,
    required this.date,
  });
}

// Sample Data
List<Order> ongoingOrders = [
  Order(
      restaurantName: "Pizza Hut",
      price: 35.25,
      items: 3,
      orderId: "#164232",
      status: "In Progress",
      date: ""),
  Order(
      restaurantName: "McDonald's",
      price: 40.15,
      items: 2,
      orderId: "#242432",
      status: "In Progress",
      date: ""),
  Order(
      restaurantName: "Starbucks",
      price: 10.20,
      items: 1,
      orderId: "#240112",
      status: "In Progress",
      date: ""),
];

List<Order> historyOrders = [
  Order(
      restaurantName: "Pizza Hut",
      price: 35.25,
      items: 3,
      orderId: "#164232",
      status: "Completed",
      date: "29 JAN, 12:30"),
  Order(
      restaurantName: "McDonald's",
      price: 40.15,
      items: 2,
      orderId: "#242432",
      status: "Completed",
      date: "30 JAN, 12:30"),
  Order(
      restaurantName: "Starbucks",
      price: 10.20,
      items: 1,
      orderId: "#240112",
      status: "Canceled",
      date: "30 JAN, 12:30"),
];
