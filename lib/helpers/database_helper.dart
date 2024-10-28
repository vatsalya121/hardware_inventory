import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hardapp/models/customer.dart';
// lib/helpers/database_helper.dart


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'customer.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE customers(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone_number TEXT)',
        );
      },
    );
  }

  // Method to insert a new customer into the database
  Future<void> insertCustomer(Customer customer) async {
    final db = await database;
    await db.insert(
      'customers',
      customer.toMap(), // Ensure the Customer model has a toMap() method
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Additional methods (query, delete, etc.) can go here
}
