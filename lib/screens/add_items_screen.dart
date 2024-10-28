import 'dart:convert';
import '../models/item.dart';
import 'package:flutter/material.dart';
import '../widgets/logout_button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/cart_provider.dart';

class AddItemsScreen extends StatefulWidget {
  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Item> items = [];
  List<Item> filteredItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems([String searchTerm = '']) async {
    setState(() {
      isLoading = true;
    });

    final uri = Uri.parse('http://localhost/inventory_app/get_items.php')
        .replace(queryParameters: {'search': searchTerm});

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            items = (data['items'] as List)
                .map((item) => Item.fromJson(item))
                .toList();
            filteredItems = items;
          });
        }
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print("Error fetching items: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      fetchItems();
    } else {
      fetchItems(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Items"),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: searchItems,
                  decoration: InputDecoration(
                    labelText: "Search Item",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.blueGrey),
                  ),
                ),
                SizedBox(height: 16),
                isLoading
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            final inCart = cartProvider.isInCart(item);
                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(item.name),
                                subtitle: Text("Unit: ${item.unit}, Price: \$${item.price}"),
                                trailing: inCart
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () => cartProvider.updateQuantity(item, -1),
                                          ),
                                          Text('${cartProvider.getQuantity(item)}'),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () => cartProvider.updateQuantity(item, 1),
                                          ),
                                        ],
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          cartProvider.addItem(item);
                                        },
                                        child: Text("Add to Cart"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          textStyle: TextStyle(fontSize: 16),
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
        backgroundColor: Colors.orange,
      ),
    );
  }
}
