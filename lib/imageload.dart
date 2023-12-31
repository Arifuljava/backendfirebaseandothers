


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class imageload extends StatefulWidget {
  const imageload({Key? key}) : super(key: key);

  @override
  State<imageload> createState() => _EmailShowingState();
}

class _EmailShowingState extends State<imageload> {
  final url = 'http://localhost:5000/tht/allIcons';
  List<String> emails = [];
  List<String> imageUrls = []; // List to store the image URLs

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
          // Extract email addresses and image URLs and add them to the respective lists
          emails = categories.map((category) => category['categoryName'] as String).toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) => 'http://localhost:5000/tht/images/$icon')
              .toList();

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
          title: const Text('Emails'),
        ),
        body: GridView.builder(
          itemCount: emails.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),

          itemBuilder: (BuildContext context, int index) {
            return Container(

              margin: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  // Handle the tap/click event here
                  // You can navigate to a new screen, show a dialog, or perform any desired action
                  print('Image tapped! Index: $index');
                },
                child: Column(
                  children: [
                    Image.network(
                      imageUrls[index],
                      width: 48,
                      height: 48,

                    ),
                    const SizedBox(height: 10),
                    Text(emails[index]!),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}