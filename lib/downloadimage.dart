

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class downloadimage extends StatefulWidget {
  const downloadimage({super.key});

  @override
  State<downloadimage> createState() => _downloadimageState();
}

class _downloadimageState extends State<downloadimage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Downloader',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final imageUrl = 'https://grozziie.zjweiting.com:8033/tht/images/image_1685520008925.png';  // Your image URL
  final imageId = '12222';  // A unique identifier for the image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Downloader'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final imagePath = await downloadAndSaveImage(imageUrl);
              await DatabaseHelper.instance.insertImagePath(imageId, imagePath);
              print(imagePath);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Image downloaded and path saved')),
              );
            } catch (e) {
              print(e);
            }
          },
          child: Text('Download Image'),
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
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'image_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE images (
            id TEXT PRIMARY KEY,
            path TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertImagePath(String id, String path) async {
    final db = await instance.database;
    await db.insert('images', {'id': id, 'path': path});
  }

  Future<List<String>> getImagePaths() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('images');

    return List.generate(maps.length, (index) {
      return maps[index]['path'];
    });
  }
}

Future<String> downloadAndSaveImage(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = imageUrl.split('/').last;
    final filePath = '${appDir.path}/$fileName';

    final File imageFile = File(filePath);
    await imageFile.writeAsBytes(response.bodyBytes);

    return filePath;
  } else {
    throw Exception('Failed to download image');
  }
}