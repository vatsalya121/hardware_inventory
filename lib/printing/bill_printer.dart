import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:hardapp/models/item.dart';
import 'package:hardapp/models/customer.dart';

Future<List<int>> createPdf(Customer customer, Map<Item, int> cartItems) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            pw.Text('Customer Info', style: pw.TextStyle(fontSize: 24)),
            pw.Text('Name: ${customer.name}', style: pw.TextStyle(fontSize: 18)),
            pw.Text('Phone: ${customer.phoneNumber}', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 20),

            // Table for Items
            pw.Text('Items:', style: pw.TextStyle(fontSize: 20)),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Header Row
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Item Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                // Item Rows
                ...cartItems.entries.map((entry) {
                  final item = entry.key;
                  final quantity = entry.value;
                  final price = item.price ?? 0;

                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(item.name ?? 'Unknown Item'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('$quantity'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('\$${(price * quantity).toStringAsFixed(2)}'),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),

            // Total Amount Calculation (if needed)
            pw.SizedBox(height: 20),
            pw.Text('Thank you for your purchase!', style: pw.TextStyle(fontSize: 18)),
            pw.Text('We appreciate your business.', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 20),
            pw.Text('Total Amount Due: \$${cartItems.entries.map((entry) => (entry.key.price ?? 0) * entry.value).reduce((a, b) => a + b).toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20)),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
