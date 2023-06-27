


import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImageDatabase {
  late Database _database;

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE images (id INTEGER PRIMARY KEY, image BLOB)',
        );
      },
    );
  }

  Future<void> insertImageFromURL(String imageURL) async {
    final response = await http.get(Uri.parse(imageURL));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      await _database.insert(
        'images',
        {'image': bytes},
      );
    } else {
      print('Failed to download image. Status code: ${response.statusCode}');
    }
  }
}

class saveimagefromemail extends StatefulWidget {
  const saveimagefromemail({Key? key}) : super(key: key);

  @override
  State<saveimagefromemail> createState() => _EmailShowingState();
}

class _EmailShowingState extends State<saveimagefromemail> {
  final imageDatabase = ImageDatabase();
  final imageURL = 'http://localhost:5000/tht/images/image_1685519884196.png';

  @override
  void initState() {
    super.initState();
    openDatabaseAndInsertImage();
  }

  Future<void> openDatabaseAndInsertImage() async {
    await imageDatabase.open();
    await imageDatabase.insertImageFromURL(imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Emails'),
        ),
        body: FutureBuilder<void>(
          future: openDatabaseAndInsertImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: Text('Image inserted successfully!'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const saveimagefromemail());
}
