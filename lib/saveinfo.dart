
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:connectivity/connectivity.dart';
class saveinfo extends StatefulWidget {
  const saveinfo({super.key});

  @override
  State<saveinfo> createState() => _saveinfoState();
}

class _saveinfoState extends State<saveinfo> {
  final dbHelper = DatabaseHelper();
  bool _nameExists = false; // State variable to store the result of the check

  Future<void> checkNameExistence(String name) async {
    bool exists = await dbHelper.isNameExists("johns_table1",name);
    setState(() {
      _nameExists = exists;
    });
  }
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  void initState()  {
    super.initState();
     checkInternetConnection();
     print(_isConnected);

    // Subscribe to connectivity changes

  }
  bool _isConnected = false;

  Future<void> checkInternetConnection() async {
    try {
      final response = await http.head('https://www.google.com' as Uri);
      setState(() {
        _isConnected = response.statusCode == 200;
      });
    } catch (e) {
      setState(() {
        _isConnected = false;
      });
    }
  }
  Future<void> checkConnectivity() async {
    final ConnectivityResult connectivityResult =
    await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SQLite Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                 // dbHelper.insertName('Ariful Islam');
                 // checkNameExistence('John Doe');
                //  print(_nameExists ? 'Name exists in the database' : 'Name does not exist');

                  checkNameExistence('John Doe');
                  if(_nameExists)
                  {
                    print("Get");
                  }
                  else
                  {
                    print("Not");
                    String tableName = 'johns_table1'; // Use a meaningful name here
                    await dbHelper.insertName(tableName, 'John Doe');
                  }


                },
                child: Text('Insert Name'),
              ),
              FutureBuilder<List<String>>(
                future: dbHelper.getNames("Border"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No Names Found');
                  } else {
                    return Column(
                      children: [
                        Text('Stored Names:'),
                        for (var name in snapshot.data!)

                          Text(name)

                        ,
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  Database? _db;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {},
    );
  }

  Future<void> createNameTable(String tableName) async {
    final db = await database;
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $tableName(id INTEGER PRIMARY KEY, name TEXT)',
    );
  }

  Future<void> insertName(String tableName, String name) async {
    await createNameTable(tableName);

    final db = await database;
    await db.insert(
      tableName,
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Added");
  }

  Future<List<String>> getNames(String tableName) async {
    await createNameTable(tableName);

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return maps[i]['name'];
    });
  }

  Future<bool> isNameExists(String tableName, String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    return maps.isNotEmpty;
  }
}
