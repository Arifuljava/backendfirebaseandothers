import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class listtt extends StatefulWidget {
  const listtt({super.key});

  @override
  State<listtt> createState() => _showcategoriesState();
}

class _showcategoriesState extends State<listtt> {
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
  final url = 'http://localhost:5000/tht/categories';
  final TextEditingController _textFieldController = TextEditingController();
  List<String> categories1 = [];
  List<dynamic>? myList;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = 'http://localhost:5000/tht/categories';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        print('Number of categories: ${categories.length}');

        // Print each category
        for (var category in categories) {
          String jsonString = jsonEncode(category);
          myList = category.values.toList();
         print(categories.first.toString());

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: ListView.builder(
          itemCount: myList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(myList?[index].toString() ?? ''),
            );
          },
        ),
      ),
    );
  }
}
