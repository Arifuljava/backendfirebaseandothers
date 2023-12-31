import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class contitionimage extends StatefulWidget {
  final String data;
  const contitionimage({Key? key, required this.data}) : super(key: key);


  @override
  State<contitionimage> createState() => _EmailShowingState();
}

class _EmailShowingState extends State<contitionimage> {
 // final url = 'http://localhost:5000/tht/allIcons';
  final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
  List<String> emails = [];
  List<String> imageUrls = []; // List to store the image URLs



late   String detector = "";


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
              .map((icon) => 'https://grozziie.zjweiting.com:8033/tht/images/$icon')
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
  void initState() {
    super.initState();
    fetchEmails();
    detector = widget.data.toString();


    print(detector);


  }

  @override
  Widget build(BuildContext context) {
    // Filter the elements based on the condition
    final elementsMatchingCondition = <Widget>[];
    final remainingElements = <Widget>[];

    for (int i = 0; i < emails.length; i++) {
      final element = Container(
        margin: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            // Handle the tap/click event here
            // You can navigate to a new screen, show a dialog, or perform any desired action
            print('Image tapped! Index: $i');
          },
          child: Column(
            children: [
              Image.network(
                imageUrls[i],
                width: 48,
                height: 48,
              ),
              const SizedBox(height: 10),
              Text(emails[i]),
            ],
          ),
        ),
      );

      if (emails[i] == detector) {
        elementsMatchingCondition.add(element);
        String dataget = imageUrls[i];


        print(imageUrls[i]);
      } else {
       // remainingElements.add(element);
      }
    }


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Text(""+detector),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            ...elementsMatchingCondition, // Display elements that match the condition first
            ...remainingElements, // Display remaining elements
          ],
        ),
      ),
    );
  }


}