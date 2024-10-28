import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hardapp/models/customer.dart';
import 'package:hardapp/helpers/database_helper.dart';
import 'package:hardapp/providers/cart_provider.dart';

class CustomerInfoScreen extends StatefulWidget {
  @override
  _CustomerInfoScreenState createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveCustomer() async {
    final name = _nameController.text;
    final phone = _phoneController.text;

    if (name.isNotEmpty && phone.isNotEmpty) {
      final customer = Customer(name: name, phoneNumber: phone);
      await DatabaseHelper().insertCustomer(customer);
      Provider.of<CartProvider>(context, listen: false)
          .setCustomer(customer, _rememberMe);
      // Navigate to next screen or perform actions after saving
    }
  }

  void _logout() {
    Provider.of<CartProvider>(context, listen: false).logout();
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Info'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
                Text('Remember Me'),
              ],
            ),
            ElevatedButton(
              onPressed: _saveCustomer,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
