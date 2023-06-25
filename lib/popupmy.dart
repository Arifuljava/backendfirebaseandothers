import 'package:flutter/material.dart';



class popupmy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pop-up Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pop-up Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Pop-up'),
          onPressed: () {
            showPopUpWindow(context);
          },
        ),
      ),
    );
  }
}

void showPopUpWindow(BuildContext context) {
  OverlayEntry overlayEntry;
  OverlayState overlayState = Overlay.of(context)!;

  TextEditingController textEditingController = TextEditingController();

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) => Positioned(
      top: MediaQuery.of(context).size.height / 2 - 150,
      left: MediaQuery.of(context).size.width / 2 - 150,
      child: SingleChildScrollView(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This is a pop-up window',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter some text',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  String enteredText = textEditingController.text;
                  print('Entered text: $enteredText');
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Close'),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);
}