import 'package:flutter/material.dart';
import 'package:food_maker/Helper/custom_colors.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  // List of labels for the address
  final List<String> labels = ['Home', 'Work', 'Other'];

  // Variables to store the inputs
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  String selectedLabel = 'Home';

  @override
  void dispose() {
    _addressController.dispose();
    _streetController.dispose();
    _postCodeController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF), // Light gray background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map button with marker
            Center(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Move to edit location'),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Address text field
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: CustomColors.primaryColor),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter address',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Street and Post Code fields
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _streetController,
                    decoration: InputDecoration(
                      hintText: "Street",
                      labelStyle: TextStyle(color: CustomColors.primaryColor),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _postCodeController,
                    decoration: InputDecoration(
                      hintText: "Post Code",
                      labelStyle: TextStyle(color: CustomColors.primaryColor),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Apartment field
            TextFormField(
              controller: _apartmentController,
              decoration: InputDecoration(
                hintText: "Apartment",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Label as section with Home, Work, Other buttons
            Text('Label as'),
            SizedBox(height: 8),
            Row(
              children: labels.map((label) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedLabel = label;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedLabel == label
                            ? CustomColors.primaryColor
                            : Colors.white,
                        foregroundColor: selectedLabel == label
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: CustomColors.primaryColor,
                        ),
                      ),
                      child: Text(label),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24),

            // Save location button
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Combine all the details into a single string including the selected label
                    final newAddress = '${_addressController.text}, ${_streetController.text}, ${_postCodeController.text}, ${_apartmentController.text}, $selectedLabel';

                    // Pass the new address back to MyAddressScreen
                    Navigator.pop(context, {
                      'address': newAddress,
                      'label': selectedLabel,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Width = full width, Height = 50
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('SAVE LOCATION', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
