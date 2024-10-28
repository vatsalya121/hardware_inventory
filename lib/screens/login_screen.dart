import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:hardapp/screens/customer_info_screen.dart';
import 'package:http/http.dart' as http; // Importing the HTTP package

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Clear the text fields when the screen is opened
    usernameController.clear();
    passwordController.clear();
  }

  Future<void> login(BuildContext context) async {
    // Define the URL of your PHP script
    final url = Uri.parse('http://localhost/inventory_app/login.php');

    // Send the POST request
    final response = await http.post(url, body: {
      'username': usernameController.text,
      'password': passwordController.text,
    });

    // Decode the response
    final responseData = json.decode(response.body);

    // Check the response
    if (responseData['success']) {
      // Navigate to the Customer Info Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerInfoScreen()),
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'])),
      );
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    // Call the login function
                    login(context);
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
