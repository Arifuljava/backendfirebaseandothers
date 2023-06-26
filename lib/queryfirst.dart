


import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class queryfirst extends StatefulWidget {
  const queryfirst({super.key});

  @override
  State<queryfirst> createState() => _queryfirstState();
}

class _queryfirstState extends State<queryfirst> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Localhost Query Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Localhost Query Demo'),
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

  Future<void> fetchData() async {
    var url = Uri.parse('http://localhost:5000/tht/icons/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _responseData = response.body;
      });
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