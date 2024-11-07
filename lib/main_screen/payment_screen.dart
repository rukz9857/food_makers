import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_maker/Helper/custom_colors.dart';

import 'congratulation_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPaymentMethod = 2; // 0: Cash, 1: Visa, 2: Mastercard, 3: PayPal

  List<Map<String, dynamic>> paymentMethods = [
    {'icon': 'assets/svgs/cash.svg', 'label': 'Cash'},
    {'icon': 'assets/svgs/visa.svg', 'label': 'Visa'},
    {'icon': 'assets/svgs/mastercard.svg', 'label': 'Mastercard'},
    {'icon': 'assets/svgs/cash.svg', 'label': 'Cash'},
    {'icon': 'assets/svgs/visa.svg', 'label': 'Visa'},
    {'icon': 'assets/svgs/mastercard.svg', 'label': 'Mastercard'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Payment", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Payment methods
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPaymentMethod = index;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 60,  // Fixed height
                            width: 60,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedPaymentMethod == index
                                    ? Colors.orange
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: SvgPicture.asset(
                              paymentMethods[index]['icon'], // Load the SVG
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            paymentMethods[index]['label'],
                            style: TextStyle(
                              color: selectedPaymentMethod == index
                                  ? Colors.orange
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            // Card or Payment Info
            Expanded(
              child: Container(

              ),
              // child: Container(
              //   padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.3),
              //         spreadRadius: 2,
              //         blurRadius: 6,
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.network(
              //         'https://via.placeholder.com/200x100', // Placeholder image for Mastercard
              //         height: 100,
              //       ),
              //       SizedBox(height: 16),
              //       Text(
              //         'No master card added',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //       SizedBox(height: 8),
              //       Text(
              //         'You can add a mastercard and save it for later',
              //         style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 14,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //       SizedBox(height: 16),
              //       ElevatedButton(
              //         onPressed: () {
              //           // Handle add new card logic
              //         },
              //         style: ElevatedButton.styleFrom(
              //           side: BorderSide(color: Colors.orange, width: 2),
              //           backgroundColor: Colors.white,
              //           foregroundColor: Colors.orange,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         child: Text('+ ADD NEW'),
              //       ),
              //     ],
              //   ),
              // ),
            ),
            SizedBox(height: 24),
            // Total Amount and Pay Button
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$96', // Total price value
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConratulationScreen(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'PAY & CONFIRM',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
