import 'package:flutter/material.dart';
import 'package:hardapp/screens/cart_screen.dart';
import 'package:hardapp/widgets/logout_button.dart';

class AddItemsScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Items"),
        backgroundColor: Colors.blueGrey, // Change if needed
        actions: [
          LogoutButton(), // Styled LogoutButton
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
              children: [
                // Search TextField
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search Item",
                    labelStyle: TextStyle(color: Colors.blueGrey), // Change label color
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8), // Input field background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none, // Remove border
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.blueGrey),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // Example list length
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text("Item $index"),
                          subtitle: Text("Price: \$${index * 10}"),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Add item to cart logic
                            },
                            child: Text("Add to Cart"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange, // Button color
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Button padding
                              textStyle: TextStyle(fontSize: 16), // Button text style
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.orange, // Floating action button color
      ),
    );
  }
}
