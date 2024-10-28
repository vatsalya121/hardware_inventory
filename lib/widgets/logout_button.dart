import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      tooltip: "Logout",
      onPressed: () async {
        // Clear user session or authentication token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear(); // This will remove all saved data

        // Navigate back to the login screen
        Navigator.pushReplacementNamed(context, '/'); // Navigate to the login screen
      },
      color: Colors.redAccent, // Change color if needed
    );
  }
}
