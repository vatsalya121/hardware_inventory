import 'package:flutter/material.dart';
import 'package:hardapp/widgets/logout_button.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.blueGrey, // AppBar color
        actions: <Widget>[
          LogoutButton(),
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
        child: Column(
          children: [
            SizedBox(height: 16), // Add some spacing
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Example cart items
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.inventory, color: Theme.of(context).colorScheme.secondary),
                      title: Text(
                        "Cart Item $index",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text("Quantity: 1"),
                      trailing: Text(
                        "\$${index * 20}",
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Logic for printing invoice
                },
                child: Text("Print Invoice"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Button padding
                  textStyle: TextStyle(fontSize: 18), // Button text style
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
