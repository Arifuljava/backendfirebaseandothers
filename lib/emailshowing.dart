


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class emailshowing extends StatefulWidget {
  const emailshowing({Key? key}) : super(key: key);

  @override
  State<emailshowing> createState() => _ListttState();
}

class _ListttState extends State<emailshowing> {
  final url = 'http://localhost:5000/tht/allIcons';
  List<String> emails = [];

  @override
  void initState() {
    super.initState();
    fetchEmails();
  }

  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        print('Number of emails: ${categories.length}');

        setState(() {
          // Extract email addresses and add them to the list
          emails = categories.map((category) => category['icon'] as String).toList();
        });
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
          title: Text('Emails'),
        ),
        body: GridView.builder(
          itemCount: emails.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.network(
                    'https://grozziie.zjweiting.com:8033/tht/images/$emails[0]',
                    width: 48,
                    height: 48,
                  ),
                  SizedBox(height: 10),
                  Text(emails[index]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}