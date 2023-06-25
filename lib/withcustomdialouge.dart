
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class withcustomdialouge extends StatefulWidget {
  const withcustomdialouge({super.key});

  @override
  State<withcustomdialouge> createState() => _withcustomdialougeState();
}

class _withcustomdialougeState extends State<withcustomdialouge> {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Demo'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('your_collection').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(child: CircularProgressIndicator()),
            );
          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Field 1: ${documents[index]['name']}'),
                subtitle: Text('Field 2: ${documents[index]['name']}'),
                // Add more fields as needed
              );
            },
          );
        },
      ),
    );
  }
}