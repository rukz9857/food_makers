import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EditProfileScreen.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String phone = "+123 456 7890";
  String bio = "I love fast food";
  String name = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadProfileInfo(); // Load profile info from SharedPreferences when the screen initializes
  }

  // Function to load profile info from SharedPreferences
  Future<void> _loadProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Name not set';
      email = prefs.getString('email') ?? 'Email not set';
    });
  }

  // Function to save profile info to SharedPreferences
  Future<void> _saveProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('edit_name', name);
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Info'),
        actions: [
          TextButton(
            onPressed: () async {
              // Navigate to Edit Profile Screen and pass existing values
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    name: name,
                    email: email,
                    phone: phone,
                    bio: bio,
                  ),
                ),
              );

              // Update profile info if data is returned
              if (result != null) {
                setState(() {
                  name = result['name'];
                  email = result['email'];
                  phone = result['phone'];
                  bio = result['bio'];
                });
                // Save the updated profile info to SharedPreferences
                await _saveProfileInfo();
              }
            },
            child: Text(
              'EDIT',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.orange.shade100,
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(bio),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text('Full Name'),
                subtitle: Text(name),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Email'),
                subtitle: Text(email),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Phone Number'),
                subtitle: Text(phone),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
