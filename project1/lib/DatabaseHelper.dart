import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database; //singleton pattern Static Instance Variable

  Future<Database?> get database async {
    if (_database != null)
      return _database; // If _database is not null, it returns the existing database instance.

    // If _database is null, instantiate it
    _database = await initDatabase();
    return _database;
  }

  Future<Database?> initDatabase() async {
    String path = await getDatabasesPath();
    //open an existing database or create a new one if it doesn't exist.
    return openDatabase(
      join(path, 'user_database.db'),
      onCreate: (db, version) {
        //create a table named 'users' ->> SQL
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, gender TEXT, email TEXT, studentId TEXT, level TEXT, password TEXT, profilePhoto BLOB)",
        );
      },
      version: 2, // Increment the version number
      //If the provided version is greater than the current version of the database (or if the database doesn't exist yet), the onCreate callback is invoked to create the database schema.
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          // Add migration script to alter the table
          db.execute(
              "ALTER TABLE users ADD COLUMN profilePhoto BLOB"); //it executes a SQL statement to add the 'profilePhoto' column
        }
      },
    );
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final Database? db = await database;
    await db?.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<bool> authenticateUser(String email, String password) async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return results.isNotEmpty;
  }

  /*Future<void> updateUserData(Map<String, dynamic> userData) async {
    final Database? db = await database;
    await db?.update(
      'users',
      userData,
      where: 'email = ?',
      whereArgs: [userData['email']],
    );
  }*/

  //Uint8List representing the bytes of the photo
  Future<void> updateProfilePhoto(String email, Uint8List photoBytes) async {
    final Database? db = await database;
    await db?.update(
      'users',
      {'profilePhoto': photoBytes},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<void> updateUserDataByEmail(
      {required String email, required Map<String, dynamic> data}) async {
    final Database? db = await database;
    await db?.update(
      'users',
      data,
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
