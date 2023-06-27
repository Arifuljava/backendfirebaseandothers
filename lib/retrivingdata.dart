




import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class retrivingdata extends StatefulWidget {
  const retrivingdata({Key? key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<retrivingdata> {
  @override
  void initState() {
    super.initState();
    initializeFirebase();
    retrieveDataFromFirestore();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> retrieveDataFromFirestore() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final collectionRef = firestoreInstance.collection('MyTesting');

    try {
      final QuerySnapshot querySnapshot = await collectionRef.get();

      final List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (final document in documents) {
        final data = document.data();
        // Process the data as per your requirement
        print('Document ID: ${document.id}');
        print('Data: $data');
      }
    } catch (error) {
      print('Error retrieving data from Firestore: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirestoreListView(),
    );
  }
}

class FirestoreListView extends StatefulWidget {
  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}

class _FirestoreListViewState extends State<FirestoreListView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> data = await getFirestoreData();
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData() async {
    List<Map<String, dynamic>> dataList = [];

    try {
      QuerySnapshot snapshot = await _firestore.collection('MyTesting').get();

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore ListView'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> item = dataList[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(item['name']),
          );
        },
      ),
    );
  }
}