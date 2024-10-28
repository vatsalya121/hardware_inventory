import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hardapp/screens/cart_screen.dart';
import 'package:hardapp/screens/login_screen.dart';
import 'package:hardapp/providers/cart_provider.dart';
import 'package:hardapp/screens/add_items_screen.dart';
// main.dart

void main() => runApp(HardwareInventoryApp());

class HardwareInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
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
          '/add-items': (context) => AddItemsScreen(),
          '/cart': (context) => CartScreen(), // No need to pass cartItems here
        },
      ),
    );
  }
}
