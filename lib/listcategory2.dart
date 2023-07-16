import 'package:backendfirebaseandothers/contitionimage.dart';
import 'package:backendfirebaseandothers/retrivingdata2.dart';
import 'package:flutter/material.dart';

import 'conti2.dart';


class listcategory2 extends StatefulWidget {
  const listcategory2({Key? key}) : super(key: key);

  @override
  State<listcategory2> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<listcategory2> {
  final List<String> emails1111 = [
    "Animals", "Beauty products", "Border", "Celebration", "Certification", "Communication", "Daily", "Direction",
    "Education", "Entertainment", "Foods and Drinks", "Home Appliance", "Human face", "Music", "Nature", "Rank", "Sports",
    "Transport", "Wash", "Weather", "Wedding", "sfasdfs", "dsafdsf", "Try", "new one icon", "Try for it", "Windows",
    "New one to try", "Mir Sult", "Rasel", "Bangladesh", "China", "Target", "try", "last one"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Categories List'),
        ),
        body: ListView.builder(
          itemCount: emails1111.length,
          itemBuilder: (BuildContext context, int index) {
            return ListViewItem(
              email: emails1111[index],
              onPressed: () {
                // Pass data to MyPage widget
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => retrivingdata2(data: emails1111[index]),
                  ),
                );
              },
            );
          },
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
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Text(
          email,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
