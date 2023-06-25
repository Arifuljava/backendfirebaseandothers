
import 'package:flutter/material.dart';

class textwatcher extends StatefulWidget {
  @override
  _TextWatcherExampleState createState() => _TextWatcherExampleState();
}

class _TextWatcherExampleState extends State<textwatcher> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextWatcher Example',
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
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextWatcher Example'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
          child: TextField(
            maxLines: 1,
            maxLength: 10,

            decoration: InputDecoration(
              border: OutlineInputBorder(),

            ),
            controller: _textEditingController,
            onChanged: (text) {
              // Handle text changes here
              print('Text changed: $text');
              // Perform desired actions with the updated text
            },
          ),
        ),
      ),
    );
  }
}