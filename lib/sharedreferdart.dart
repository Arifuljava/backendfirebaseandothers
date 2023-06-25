





import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sharedreferdart extends StatefulWidget {
  const sharedreferdart({super.key});

  @override
  State<sharedreferdart> createState() => _sharedreferdartState();
}

class _sharedreferdartState extends State<sharedreferdart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Example',
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
  String _storedValue = '';

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  Future<void> storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', 'Hello, Flutter!');
    print("Done");
  }

  Future<void> retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('key') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Storage Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stored Value:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _storedValue,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: storeData,
              child: Text('Store Data'),
            ),
          ],
        ),
      ),
    );
  }
}