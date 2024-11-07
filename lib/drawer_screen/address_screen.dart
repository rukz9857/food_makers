import 'package:flutter/material.dart';
import 'Editaddress_screen.dart'; // Import the EditAddressScreen

class MyAddressScreen extends StatefulWidget {
  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  List<Map<String, String>> addresses = [
    {'address': '1234 Street Name, New Jersey', 'label': 'Home'},
    {'address': '5678 Office Road, California', 'label': 'Work'}
  ];

  void _showEditDialog(BuildContext context, int index) {
    final TextEditingController addressController = TextEditingController(text: addresses[index]['address']);
    final TextEditingController labelController = TextEditingController(text: addresses[index]['label']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Address'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: labelController,
                decoration: InputDecoration(labelText: 'Label'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  addresses[index] = {
                    'address': addressController.text,
                    'label': labelController.text,
                  };
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showRemoveDialog(BuildContext context, int index) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Removal'),
          content: Text('Are you sure you want to remove this address?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog with cancel
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Close the dialog with confirm
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _removeAddress(int index) {
    setState(() {
      addresses.removeAt(index); // Remove the item from the list
    });
  }

  void _navigateToEditAddress() async {
    final newAddress = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => EditAddressScreen()),
    );

    if (newAddress != null) {
      setState(() {
        addresses.add(newAddress); // Add the new address to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final addressData = addresses[index];
                  return Dismissible(
                    key: Key(addressData['address']!),
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.endToStart) {
                        // Show the confirmation dialog
                        bool? shouldRemove = await _showRemoveDialog(context, index);
                        if (shouldRemove == true) {
                          _removeAddress(index); // Remove address if confirmed
                        }
                        return shouldRemove; // Return true to dismiss, false to cancel
                      }
                      return false; // Default to not dismissing
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Icon(addressData['label'] == 'Home' ? Icons.home_outlined : Icons.work_outline),
                        title: Text(addressData['label']!),
                        subtitle: Text(addressData['address']!),
                        trailing: IconButton(
                          icon: Icon(Icons.edit_outlined),
                          onPressed: () {
                            _showEditDialog(context, index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: _navigateToEditAddress,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Width = full width, Height = 50
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('ADD NEW ADDRESS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
