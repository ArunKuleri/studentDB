// import 'package:sqflite/sqflite.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "your_database_name.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        firstName TEXT,
        lastName TEXT,
        dob TEXT,
        bloodGroup TEXT,
        division TEXT,
        createdAt TEXT
      )
    ''');
    });
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (index) {
      return User(
          username: maps[index]['''
username'''],
          password: maps[index]['''
password'''],
          firstName: maps[index]['''
firstName'''],
          lastName: maps[index]['''
lastName'''],
          dob: maps[index]["""
dob"""],
          bloodGroup: maps[index]["""
bloodGroup"""],
          division: maps[index]["""
division"""]);
    });
  }
}

class User {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String dob;
  final String bloodGroup;
  final String division;

  User({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.bloodGroup,
    required this.division,
  });

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "dob": dob,
      "bloodGroup": bloodGroup,
      'division': division,
    };
  }
}
