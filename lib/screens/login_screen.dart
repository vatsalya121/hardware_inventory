import 'package:flutter/material.dart';
import 'package:hardapp/screens/customer_info_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INVENTO"),
        backgroundColor: Colors.blueGrey, // Change the app bar color if needed
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent], // Background gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Center the content vertically
              children: [
                // Username TextField
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 7, 7, 7)), // Change label color
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // Input field background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none, // Remove border
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Password TextField
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)), // Change label color
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // Input field background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none, // Remove border
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 32),
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Logic to validate login and navigate to customer info screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerInfoScreen()),
                    );
                  },
                  child: Text("Login"),
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
