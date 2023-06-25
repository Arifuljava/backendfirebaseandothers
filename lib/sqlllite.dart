import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class sqlllite extends StatefulWidget {
  const sqlllite({super.key});

  @override
  State<sqlllite> createState() => _sqllliteState();
}

class _sqllliteState extends State<sqlllite> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  Future<List<Map<String, dynamic>>> _getData() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query('my_table');
  }

  Future<void> _insertData() async {
    String name = nameController.text;
    int age = int.tryParse(ageController.text) ?? 0;

    Map<String, dynamic> data = {
      'name': name,
      'age': age,
    };

    await DatabaseHelper.instance.insertData(data);
    setState(() {
      nameController.clear();
      ageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Details',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
            ),
            ElevatedButton(
              onPressed: _insertData,
              child: Text('Insert Data'),
            ),
            SizedBox(height: 20),
            Text(
              'Stored Data',
              style: TextStyle(fontSize: 20),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Column(
                    children: data.map((item) {
                      return ListTile(
                        title: Text('Name: ${item['name']}'),
                        subtitle: Text('Age: ${item['age']}'),
                      );
                    }).toList(),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'mydatabase.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
      )
    ''');
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('my_table', data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query('my_table');
  }
}