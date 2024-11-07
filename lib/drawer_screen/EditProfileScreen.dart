import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController bioController;

  EditProfileScreen({
    required String name,
    required String email,
    required String phone,
    required String bio,
  })  : nameController = TextEditingController(text: name),
        emailController = TextEditingController(text: email),
        phoneController = TextEditingController(text: phone),
        bioController = TextEditingController(text: bio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.orange.shade100,
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 40),
            ElevatedButton(

              onPressed: () {
                // Passing updated values back to the previous screen
                Navigator.pop(context, {
                  'name': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'bio': bioController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 12), // Additional vertical padding
              ),
              child: Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}
