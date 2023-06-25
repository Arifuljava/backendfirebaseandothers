import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class manydata extends StatefulWidget {
  const manydata({Key? key}) : super(key: key);

  @override
  State<manydata> createState() => _ManyDataState();
}

class _ManyDataState extends State<manydata> {
  String _storedValue = "";
  String value_shared = "";

  Future<void> retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('key1') ?? '';
      String get2 = prefs.getString("key2") ?? '';

      value_shared = _storedValue + "\n" + get2;
      print("" + value_shared);
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Local Storage Example'),
        ),
        body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Column(
            children: [
              MyHomePage(),
              Text("TTTT"+_storedValue)
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Center(
        child: Text(
          'Data added to SharedPreferences!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Future<void> storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Add multiple data entries
    prefs.setString('key1', 'Value 1');
    prefs.setString('key2', 'Value 2');
    prefs.setInt('key3', 42);
    prefs.setBool('key4', true);
    prefs.setStringList('key5', ['Value A', 'Value B']);
    print("kkkk");
  }
}
