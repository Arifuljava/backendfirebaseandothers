
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class withquery extends StatefulWidget {
  const withquery({super.key});

  @override
  State<withquery> createState() => _withqueryState();
}

class _withqueryState extends State<withquery> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Query with Parameters Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Query with Parameters Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _responseData = '';
  int _dataCount=0;
  Future<void> fetchData() async {
    var url = Uri.parse('http://localhost:5000/tht/icons?categoryname=Animal');
    var response = await http.get(url);

    if (response.statusCode == 200) {

      var jsonData = json.decode(response.body);


      print(jsonData.toString());


    } else {
      setState(() {
        _responseData = 'Request failed with status: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: fetchData,
                child: Text('Fetch Data'),
              ),
              SizedBox(height: 16),
              Text(
                _responseData,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}