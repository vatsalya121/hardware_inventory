import 'package:flutter/material.dart';
import 'package:hardapp/models/item.dart';
import 'package:hardapp/models/customer.dart';

class CartProvider with ChangeNotifier {
  // Using a Map to store items and their quantities
  Map<Item, int> _cartItems = {};
  Customer? _customer; // Store customer information
  bool _rememberMe = false; // Flag for "Remember Me"

  // Exposing the cart items
  Map<Item, int> get cartItems => _cartItems;

  // Get customer info
  Customer? get customer => _customer;

  // Get remember me status
  bool get rememberMe => _rememberMe;

  // Method to check if an item is already in the cart
  bool isInCart(Item item) {
    return _cartItems.containsKey(item);
  }

  // Add an item or update its quantity if already in the cart
  void addItem(Item item) {
    if (_cartItems.containsKey(item)) {
      _cartItems[item] = _cartItems[item]! + 1;
    } else {
      _cartItems[item] = 1; // Add new item with quantity 1
    }
    notifyListeners();
  }

  // Update the quantity of an item in the cart
  void updateQuantity(Item item, int change) {
    if (_cartItems.containsKey(item)) {
      final newQuantity = (_cartItems[item]! + change).clamp(0, double.infinity).toInt();
      if (newQuantity <= 0) {
        _cartItems.remove(item);
      } else {
        _cartItems[item] = newQuantity; // Update the quantity
      }
      notifyListeners();
    }
  }

  // Get the quantity of a specific item
  int getQuantity(Item item) => _cartItems[item] ?? 0;

  // Set customer data and remember status
  void setCustomer(Customer customer, bool remember) {
    _customer = customer;
    _rememberMe = remember;
    notifyListeners();
  }

  // Clear cart and customer data on logout
  void logout() {
    _cartItems.clear();
    if (!_rememberMe) {
      _customer = null; // Clear customer data if not remembered
    }
    notifyListeners();
  }
}
