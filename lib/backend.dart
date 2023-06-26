


import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
class backend extends StatefulWidget {
  const backend({Key? key}) : super(key: key);

  @override
  State<backend> createState() => _BackendState();
}

class _BackendState extends State<backend> {
  bool isLoading = false;
  bool userExists = false;

  Future<void> checkUserExists(String userId) async {
    setState(() {
      isLoading = true;
    });

    final url = 'node ser';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': userId}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final exists = jsonResponse['exists'] as bool?;
        setState(() {
          userExists = exists ?? false;
        });
      } else {
        setState(() {
          userExists = false;
          print("fff");
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        userExists = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  FocusNode _focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User Check'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: TextField(
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: controller,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    print('Enter Information');
                  } else {
                    checkUserExists(controller.text.toLowerCase().toString());
                  }
                },
                child: const Text('Check User'),
              ),
              const SizedBox(height: 16),
              if (isLoading)
                const CircularProgressIndicator()
              else if (userExists)
                const Text('User exists on the server')
              else
                const Text('User does not exist on the server')

            ],
          ),
      ),

      ),
    );
  }
}

final String apiUrl = 'https://customer-server-theta.vercel.app/tht/users/add';

Future<void> addUser() async {
  // Define the data to be sent in the request body
  Map<String, dynamic> userData = {
    'name': 'John Doe',
    'email': 'johndoe@example.com',
    // Add any additional fields as required by the API
  };

  // Encode the data as JSON
  String jsonBody = json.encode(userData);

  try {
    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response here
      print('User added successfully!');
    } else {
      // Request failed, handle the error
      print('Failed to add user. Error: ${response.statusCode}');
    }
  } catch (error) {
    // Exception occurred while making the request
    print('Failed to add user. Error: $error');
  }
}
