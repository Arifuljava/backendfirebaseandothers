
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class onebyone extends StatefulWidget {
  const onebyone({super.key});

  @override
  State<onebyone> createState() => _onebyoneState();
}

class _onebyoneState extends State<onebyone> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Categories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> myList = [];

  Future<void> fetchCategories() async {
    final url = 'http://localhost:5000/tht/categories';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        print('Number of categories: ${categories.length}');

        setState(() {
          myList = categories;
        });

        // Access each value individually
        for (var value in myList) {
          print(value); // Do whatever you want with the value
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
          title: Text('Fetch Categories'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: fetchCategories,
                child: Text('Fetch Categories'),
              ),
              SizedBox(height: 16),
              Text(
                'Number of categories: ${myList.length}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(myList[index].toString()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
