import 'package:flutter/material.dart';
import 'package:hardapp/screens/login_screen.dart';
import 'package:hardapp/screens/add_items_screen.dart';
import 'package:hardapp/screens/cart_screen.dart'; // Import your CartScreen here

void main() => runApp(HardwareInventoryApp());

class HardwareInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hardware Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        hintColor: Colors.orange,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: '/', // Start at the login screen
      routes: {
        '/': (context) => LoginScreen(),
        '/add-items': (context) => AddItemsScreen(), // Define the route for AddItemsScreen
        '/cart': (context) => CartScreen(), // Define the route for CartScreen
      },
    );
  }
}
