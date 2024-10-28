// models/customer.dart

class Customer {
  final int? id; // Make id nullable for new customer
  final String name;
  final String phoneNumber;

  Customer({
    this.id,
    required this.name,
    required this.phoneNumber,
  });

  // Convert a Customer object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
    };
  }

  // Optionally, you can add a factory method to create a Customer from a Map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phone_number'],
    );
  }
}
