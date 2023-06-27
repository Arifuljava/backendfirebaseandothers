


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class fetchdata extends StatefulWidget {
  const fetchdata({super.key});

  @override
  State<fetchdata> createState() => _fetchdataState();
}

class _fetchdataState extends State<fetchdata> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Fetching Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataFetchingPage(),
    );
  }
}

class DataFetchingPage extends StatefulWidget {
  @override
  _DataFetchingPageState createState() => _DataFetchingPageState();
}

class _DataFetchingPageState extends State<DataFetchingPage> {
  late List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    final url = Uri.parse('http://localhost:5000/tht/allIcons');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successful request
      setState(() {
        data = jsonDecode(response.body);
      });
    } else {
      // Request failed
      print('Failed to fetch data. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Fetching Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            if (data.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Icon ID: ${data[index]['email']}'),
                      subtitle: Text('Icon Name: ${data[index]['email']}'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}