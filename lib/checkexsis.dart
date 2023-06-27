

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class checkexsis extends StatefulWidget {
  const checkexsis({super.key});

  @override
  State<checkexsis> createState() => _checkexsisState();
}

class _checkexsisState extends State<checkexsis> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Check Localhost URL'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              fetchValuesFromURL();
            },
            child: Text('Check URL'),
          ),
        ),
      ),
    );
  }
}

void checkLocalhost() async {
  final url = Uri.parse('http://localhost:5000/tht/icons');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Assuming the response is a JSON array, you can iterate through the values
      for (var value in data) {
        print(value);
      }
      print('URL exists');
    } else {
      print('URL does not exist');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void fetchValuesFromURL() async {
  final url = Uri.parse('http://localhost:5000/tht/icons');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Assuming the response is a JSON array, you can iterate through the values
      for (var value in data) {
        print(value);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}