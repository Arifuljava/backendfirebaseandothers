


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;

// final url = 'http://localhost:5000/tht/allIcons';
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];
late   String detector = "";
class ShowIconContainer extends StatefulWidget {
  final String data;
  const ShowIconContainer({Key? key,required this.data}) : super(key: key);

  @override
  _ShowIconContainerState createState() => _ShowIconContainerState();
}

class _ShowIconContainerState extends State<ShowIconContainer> {
   // List to store the image URLs

  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        print('Number of emails: ${categories.length}');

        setState(() {
          // Extract email addresses and image URLs and add them to the respective lists
          emails = categories.map((category) => category['categoryName'] as String).toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) => 'https://grozziie.zjweiting.com:8033/tht/images/$icon')
              .toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchEmails();
    initializeFirebase();
    detector = widget.data.toString();



  }



  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }



  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < emails.length; i++) {


      if (emails[i] == detector) {

        String dataget = imageUrls[i];
        bool isDataFound = false;
        checkDocumentExists(dataget).then((value) {
          isDataFound = value;
          if (isDataFound) {
            print('Document with email "ariful@gmail.com" exists.');

          } else {
            print('Document with email "ariful@gmail.com" does not exist.');
            addData(dataget);
            print("Data Added");
            // elementsMatchingCondition.add(element);
          }
        }).catchError((error) {
          print('An error occurred: $error');
        });

        print(imageUrls[i]);
      } else {
        // remainingElements.add(element);
      }
    }
    return MaterialApp(
      title: 'Firestore ListView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: FirestoreListView(),
    );
  }
}


Future<void> addData(String dataaddtobe) async{
  try{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    firebaseFirestore.collection(mydetctor)
        .add({
      "data": ""+dataaddtobe
    });


  }catch(e)
  {
    print("Error : "+e.toString());
  }
}
String mydetctor="";
Future<bool> checkDocumentExists(String email) async {
  final collectionRef = FirebaseFirestore.instance.collection(mydetctor);
  final querySnapshot = await collectionRef.where('data', isEqualTo: email).get();

  return querySnapshot.size > 0;
}


class FirestoreListView extends StatefulWidget {
  final String data2;

  const FirestoreListView({super.key, required this.data2});

  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}


class _FirestoreListViewState extends State<FirestoreListView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];

  Timer? _timer;
  int _counter = 0;


  @override
  void initState() {
    super.initState();


    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;
       // print(_counter.toString());

        mydetctor=widget.data2.toString();
        widget.data2;
        fetchData(mydetctor);
      //  print("gettt");

        //print(widget.data2);
      });
    });

  }
  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer?.cancel();
    super.dispose();
  }
  Future<void> fetchData(String colletiondata) async {
    List<Map<String, dynamic>> data = await getFirestoreData(colletiondata);
    setState(() {
      dataList = data;
    });
  }

  Future<List<Map<String, dynamic>>> getFirestoreData(String mycollection) async {
    List<Map<String, dynamic>> dataList = [];

    try {
      QuerySnapshot snapshot = await _firestore.collection(mycollection).get();
      print(mycollection);

      snapshot.docs.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error retrieving Firestore data: $e');
    }
    //print(dataList);

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          padding: EdgeInsets.all(10),
          height:500,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Adjust the cross axis count as per your requirement
            ),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = dataList[index];

              return GestureDetector(
                onTap: (){
                  setState(() {
                    print("Print Index $item['data']");
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),

                  child: Image.network(
                    item['data'],

                  ),
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}