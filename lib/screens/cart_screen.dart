import 'dart:typed_data';
import '../models/item.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import '../widgets/logout_button.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
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
                onPressed: () async {
                  final pdfData = await _generateInvoicePDF(context);
                  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
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

  Future<Uint8List> _generateInvoicePDF(BuildContext context) async {
    final pdf = pw.Document();

    // Get cart items
    final cartItems = context.read<CartProvider>().cartItems;

    // Add a page with customer info and cart items
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Customer Info', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              // Add customer details here if needed
              pw.SizedBox(height: 20),
              pw.Text('Items:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems.keys.elementAt(index);
                  final quantity = cartItems[item] ?? 0;
                  return pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('${item.name} (${item.unit})'),
                      pw.Text('Qty: $quantity'),
                      pw.Text('\$${((item.price ?? 0) * quantity).toStringAsFixed(2)}'),
                    ],
                  );
                },
              ),
              pw.SizedBox(height: 20),
              pw.Text('Total: \$${cartItems.entries.map((e) => e.key.price * e.value).reduce((a, b) => a + b).toStringAsFixed(2)}'),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }
}
