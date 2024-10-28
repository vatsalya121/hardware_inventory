import 'package:flutter/material.dart';
import '../widgets/logout_button.dart';
import 'package:hardapp/screens/cart_screen.dart';
import 'package:hardapp/screens/add_items_screen.dart';

class CustomerInfoScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Information"),
        backgroundColor: Colors.blueGrey, // Change if needed
        actions: [
          LogoutButton(), // Use a more styled LogoutButton (explained below)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Center the content vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center the text fields
              children: [
                Text(
                  "Enter Customer Details",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 16),
                // Customer Name TextField
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Customer Name',
                    labelStyle: TextStyle(color: Colors.blueGrey), // Change label color
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // Input field background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none, // Remove border
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Phone Number TextField
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.blueGrey), // Change label color
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // Input field background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none, // Remove border
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // Continue Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Cart Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddItemsScreen()),
                    );
                  },
                  child: Text("Continue"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Button padding
                    textStyle: TextStyle(fontSize: 18), // Button text style
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
