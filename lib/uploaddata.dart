import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class uploaddata extends StatefulWidget {
  const uploaddata({super.key});

  @override
  State<uploaddata> createState() => _uploaddataState();
}

class _uploaddataState extends State<uploaddata> {
  Future<List<QueryDocumentSnapshot>> getData() async {
    try {
      QuerySnapshot querySnapshot =
      await firebaseFirestore.collection('MyTesting').get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error retrieving data: $e');
      return [];
    }
  }
  Future<void> addData() async{
    try{
      firebaseFirestore.collection("MyTesting")
          .add({
        "name": ""+textEditingController.text.toString()
      });


    }catch(e)
    {
      print("Error : "+e.toString());
    }
  }
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Future<void>registeremail(String email,String password) async{
    try{
      print(""+email);
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Login successful, user is signed in
      User? user = userCredential.user;
      print('Registered');




    }catch(e)
    {
      print(""+e.toString());
    }
  }
  Future<void> loginaccount(String email,password) async{
    try{

      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Login successful, user is signed in
      User? user = userCredential.user;
      print('Registered');
    }catch(e)
    {
      print(""+e.toString());

    }
  }
  TextEditingController textEditingController= new TextEditingController();
  TextEditingController textEditingController11= new TextEditingController();
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance; 
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text("Firebase Firestore"),
       ),
       body: Center(
         child: Column(
           children: <Widget>[
             Container(
               width: 200,
               margin: EdgeInsets.only(top: 20,left: 1,bottom: 10,right: 1),
               alignment: Alignment.center,
               child: TextField(


                 decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   hintText: "Enter Email",
                   labelText: "Enter Email"
                 ),
                 controller: textEditingController,
               ),
             ),
             Container(
               width: 200,
               margin: EdgeInsets.only(top: 20,left: 1,bottom: 10,right: 1),
               alignment: Alignment.center,
               child: TextField(


                 decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     hintText: "Enter Password",
                     labelText: "Enter Password"
                 ),
                 controller: textEditingController11,
               ),
             ),
             Container(
               margin: EdgeInsets.only(top: 10,bottom: 10),
               child: ElevatedButton(onPressed: ()async  {
                 setState(() async  {
                   if(textEditingController.text== ""|| textEditingController.text==null)
                     {
                       print("Enter Information");
                     }
                   else{
                     print(textEditingController.text.toString());
                     loginaccount(textEditingController.text, textEditingController11.text);

print("Done");


                   }
                 });
               }, child: Text("Submit")),
             ),
             ElevatedButton(onPressed: (){
              /*
               setState(() {
                 print("Clied");
                 getData().then((docs) {
                   for (QueryDocumentSnapshot doc in docs) {
                     print('Document ID: ${doc.id}');
                     print('Field 1: ${doc['name']}');
                     // Access more fields as needed
                     print('------------');
                   }
                 });
               });
               */
               registeremail('test@example.com', 'password123');

             }, child: Text("Retrive all data"))

           ],
         ),
       ),
     ),
   );
  }
}
