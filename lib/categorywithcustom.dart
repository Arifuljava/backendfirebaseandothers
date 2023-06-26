



import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class categorywithcustom extends StatefulWidget {
  const categorywithcustom({Key? key});

  @override
  State<categorywithcustom> createState() => _showcategoriesState();
}

class _showcategoriesState extends State<categorywithcustom> {
  final url = 'http://localhost:5000/tht/categories';
  final TextEditingController _textFieldController = TextEditingController();
  List<String> categories = [];

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

        setState(() {
          this.categories = categories.map((category) => category.toString()).toList();
        });

        print('Number of categories: ${categories.length}');
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
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(categories[index]),
            );
          },
        ),
      ),

    );
  }
}
