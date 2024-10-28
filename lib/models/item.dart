// models/item.dart
class Item {
  final int id;
  final String name;
  final String unit;
  final double price;
  int quantity;

  Item({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    this.quantity = 1,
  });

  // Factory method to create an Item instance from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['description'],
      unit: json['unit'],
      price: double.parse(json['price'].toString()),
      quantity: json.containsKey('quantity') ? json['quantity'] : 1,
    );
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item && other.id == id; // Compare based on the unique ID
  }

  // Override hashCode
  @override
  int get hashCode => id.hashCode; // Use id's hash code
}
