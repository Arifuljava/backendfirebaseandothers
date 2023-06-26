


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class showcategories extends StatefulWidget {
  const showcategories({super.key});

  @override
  State<showcategories> createState() => _showcategoriesState();
}

class _showcategoriesState extends State<showcategories> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryScreen(),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final url = 'http://localhost:5000/tht/icons';
  final TextEditingController _textFieldController = TextEditingController();
  List<String> categories1 = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }
  late List<dynamic> myList;
  Future<void> fetchCategories() async {
    final url = 'http://localhost:5000/tht/icons';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        print('Number of categories: ${categories.length}');

        // Print each category
        for (var category in categories) {
          String jsonString = jsonEncode(category);
          myList  = category.values.toList();
          print(myList);
          print(category);
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _textFieldController,
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Categories',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
