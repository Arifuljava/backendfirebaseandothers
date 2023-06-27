



import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class imagestore extends StatefulWidget {
  const imagestore({super.key});

  @override
  State<imagestore> createState() => _imagestoreState();
}

class _imagestoreState extends State<imagestore> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SQLite Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              storeText('Hello, SQLite!');
            },
            child: Text('Store Text'),
          ),
        ),
      ),

    );
  }

  void storeText(String text) async {
    int result = await databaseHelper.insertText(text);
    if (result != 0) {
      print('Text stored successfully!');
    } else {
      print('Failed to store text!');
    }
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'my_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE my_table(id INTEGER PRIMARY KEY, text TEXT)');
  }

  Future<int> insertText(String text) async {
    Database? db = await database;
    return await db!.insert('my_table', {'text': text});
  }
}