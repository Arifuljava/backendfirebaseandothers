/*


import 'package:backendfirebaseandothers/retrivingdata23.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class mylisttt extends StatefulWidget {
  const mylisttt({super.key});

  @override
  State<mylisttt> createState() => _mylistState();
}
final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];
String selectedCategory = "";
class _mylistState extends State<mylisttt> {
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  final List<String> categories = [
    "Animals", "Beauty products", "Border", "Celebration", "Certification", "Communication", "Daily", "Direction",
    "Education", "Entertainment", "Foods and Drinks", "Home Appliance", "Human face", "Music", "Nature", "Rank", "Sports",
    "Transport", "Wash", "Weather", "Wedding", "sfasdfs", "dsafdsf", "Try", "new one icon", "Try for it", "Windows",
    "New one to try", "Mir Sult", "Rasel", "Bangladesh", "China", "Target", "try", "last one"
  ];

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
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  @override
  void initState() {
    super.initState();
    fetchEmails();
    initializeFirebase();
  }
  bool selectindex= false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListViewItem(
                    email: categories[index],
                    onPressed: () {
                      selectindex= true;


                      setState(() {
                        selectedCategory = categories[index];
                        print(selectedCategory);
                        print("Clicked");
                      });


                      /*// Pass data to MyPage widget
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowIconContainer(data: categories[index]),
                        ),
                      );*/

                    },
                  );
                },
              ),
            ),

           if(selectindex)



              Container(
                 height: 300,
                 width: double.infinity,
                 color: Colors.white,
                 child: FirestoreListView(data2: selectedCategory,),

               )


          ],
        ),
      ),
    );
  }


}


class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;

  ListViewItem({required this.email, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Center(
          child: Text(
            email,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}

 */
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class mylisttt extends StatefulWidget {
  const mylisttt({Key? key});

  @override
  State<mylisttt> createState() => _mylistState();
}

final url = 'https://grozziie.zjweiting.com:8033/tht/allIcons';
List<String> emails = [];
List<String> imageUrls = [];
String selectedCategory = "";

class _mylistState extends State<mylisttt> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final List<String> categories = [
    "Animals",
    "Beauty products",
    "Border",
    "Celebration",
    "Certification",
    "Communication",
    "Daily",
    "Direction",
    "Education",
    "Entertainment",
    "Foods and Drinks",
    "Home Appliance",
    "Human face",
    "Music",
    "Nature",
    "Rank",
    "Sports",
    "Transport",
    "Wash",
    "Weather",
    "Wedding",
    "sfasdfs",
    "dsafdsf",
    "Try",
    "new one icon",
    "Try for it",
    "Windows",
    "New one to try",
    "Mir Sult",
    "Rasel",
    "Bangladesh",
    "China",
    "Target",
    "try",
    "last one"
  ];

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

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    fetchEmails();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListViewItem(
                    email: categories[index],
                    selected: selectedCategory == categories[index],
                    onPressed: () {
                      setState(() {
                        selectedCategory = categories[index];
                        print(selectedCategory);
                        print("Clicked");
                      });
                    },
                  );
                },
              ),
            ),
            if (selectedCategory.isNotEmpty)
              SingleChildScrollView(
                child: Container(
                  height: 600,
                  width: double.infinity,
                  color: Colors.blue,
                  child: FirestoreListView2(data2: selectedCategory),
                ),
              ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final String email;
  final VoidCallback? onPressed;
  final bool selected;

  ListViewItem({required this.email, this.onPressed, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: selected ? Colors.blue : Colors.transparent,
        ),
        child: Center(
          child: Text(
            email,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}



//////
String mydetctor="";
class FirestoreListView2 extends StatefulWidget {
  final String data2;

  const FirestoreListView2({super.key, required this.data2});

  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}


class _FirestoreListViewState extends State<FirestoreListView2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> dataList = [];

  Timer? _timer;
  int _counter = 0;
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
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
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
  @override
  void initState() {
    super.initState();


    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update the state variable
      setState(() {
        _counter++;
        fetchEmails();
        initializeFirebase();
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

    for (int i = 0; i < emails.length; i++) {


      if (emails[i] == mydetctor) {

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
      } else {
        // remainingElements.add(element);
      }
    }

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