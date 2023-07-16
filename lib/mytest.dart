import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:http/http.dart' as http;


final List<String> categories = [
  "Animals", "Beauty products", "Border", "Celebration", "Certification", "Communication", "Daily", "Direction",
  "Education", "Entertainment", "Foods and Drinks", "Home Appliance", "Human face", "Music", "Nature", "Rank", "Sports",
  "Transport", "Wash", "Weather", "Wedding", "sfasdfs", "dsafdsf", "Try", "new one icon", "Try for it", "Windows",
  "New one to try", "Mir Sult", "Rasel", "Bangladesh", "China", "Target", "try", "last one"
];
String selectedItem = "";
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];


class mytest extends StatefulWidget {
  const mytest({Key? key}) : super(key: key);

  @override
  _MyTestState createState() => _MyTestState();
}

class _MyTestState extends State<mytest> {
  bool isSecondContainerVisible = false;

  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categories = jsonResponse as List<dynamic>;

        print('Number of emails: ${categories.length}');

        setState(() {
          // Extract email addresses and image URLs and add them to the respective lists
          emails = categories
              .map((category) => category['categoryName'] as String)
              .toList();
          imageUrls = categories
              .map((category) => category['icon'] as String?)
              .where((icon) => icon != null)
              .map((icon) =>
          'https://grozziie.zjweiting.com:8033/tht/images/$icon')
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
    // TODO: implement initState
    super.initState();
    fetchEmails();
    initializeFirebase();
  }
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Categories List'),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListViewItem(
                    email: categories[index],
                    onPressed: () {
                      setState(() {
                        selectedItem = categories[index];

                        print(categories.length);

                        if (emails[index] == selectedItem) {
                          String dataget = imageUrls[index];

                          FirebaseFirestore firebaseFirestore =
                              FirebaseFirestore.instance;
                          bool isDataFound = false;

                          checkDocumentExists(dataget).then((value) {
                            isDataFound = value;
                            if (isDataFound) {
                              isSecondContainerVisible = true;
                              print('Document with email "ariful@gmail.com" exists.');
                            } else {
                              print('Document with email "ariful@gmail.com" does not exist.');
                              addData(dataget);
                              isSecondContainerVisible = true;
                              print("Data Added");
                            }
                          }).catchError((error) {
                            print('An error occurred: $error');
                          });

                          print(imageUrls[index]);
                        } else {
                          // remainingElements.add(element);
                        }


                      });
                      print(selectedItem);
                    },
                  );
                },
              ),
            ),
            if (isSecondContainerVisible)
              Container(
                height: 250,
                margin: EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.red,
                child: Container(
                  child: FirestoreListView11(),


                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ListViewItem extends StatefulWidget {
  final String email;
  final VoidCallback? onPressed;

  ListViewItem({required this.email, this.onPressed});

  @override
  _ListViewItemState createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          //color: isClicked ? Colors.red : Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            widget.email,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(mytest());
}
Future<void> addData(String dataaddtobe) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection(selectedItem).add({
      "data": "" + dataaddtobe,
    });
  } catch (e) {
    print("Error : " + e.toString());
  }
}

Future<bool> checkDocumentExists(String email) async {
  final collectionRef = FirebaseFirestore.instance.collection(selectedItem);
  final querySnapshot =
  await collectionRef.where('data', isEqualTo: email).get();
  return querySnapshot.size > 0;
}


class FirestoreListView11 extends StatefulWidget {
  @override
  _FirestoreListViewState1 createState() => _FirestoreListViewState1();
}
class _FirestoreListViewState1 extends State<FirestoreListView11>
{
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
      QuerySnapshot snapshot = await _firestore.collection(selectedItem).get();

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

    return MaterialApp(
      home: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Firestore ListView'),
          ),
          body: Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the cross axis count as per your requirement
              ),
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> item = dataList[index];
                return Image.network(
                  item['data'],
                  width: 30,
                  height: 30,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}