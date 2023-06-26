import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirstGetImage extends StatefulWidget {
  const FirstGetImage({Key? key}) : super(key: key);

  @override
  _FirstGetImageState createState() => _FirstGetImageState();
}

class _FirstGetImageState extends State<FirstGetImage> {
  String? imageUrl;

  Future<void> retrieveImage() async {
    String baseUrl = 'http://localhost:5000/tht/icons';
    Map<String, String> queryParams = {'categoryName': 'Animals'};

    String queryString = Uri(queryParameters: queryParams).query;
    String url = Uri.http(baseUrl, '', queryParams).toString();

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Image retrieval successful
      setState(() {
        imageUrl = url;
      });
    } else {
      // Image retrieval failed
      print('Failed to retrieve the image. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Retrieval Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (imageUrl != null)
                Image.network(
                  imageUrl!,
                  width: 200,
                  height: 200,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: retrieveImage,
                child: Text('Retrieve Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(FirstGetImage());
}
