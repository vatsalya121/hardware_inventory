import '../models/item.dart';
import 'package:flutter/material.dart';
import '../widgets/logout_button.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.blueGrey,
        actions: [LogoutButton()],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.cartItems.keys.elementAt(index);
                  final quantity = cartProvider.cartItems[item] ?? 0;

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.inventory, color: Theme.of(context).colorScheme.secondary),
                      title: Text(
                        item.name ?? 'Unknown Item',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => cartProvider.updateQuantity(item, -1),
                          ),
                          Text("Qty: $quantity ${item.unit ?? ''}"),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => cartProvider.updateQuantity(item, 1),
                          ),
                        ],
                      ),
                      trailing: Text(
                        "\$${((item.price ?? 0) * quantity).toStringAsFixed(2)}",
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
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
