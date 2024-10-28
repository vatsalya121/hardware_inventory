import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      tooltip: "Logout",
      onPressed: () {
        // Logic for logging out
      },
      color: Colors.redAccent, // Change color if needed
    );
  }
}
