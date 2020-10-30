import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String mainHeading = 'Main Heading Section';
  String subheading = 'Enter Subheading Here';
  final url =
      'https://drive.google.com/uc?export=view&id=112jcK61HSBZ6Jc8pMf6qWVk7nT9Ld4Xv';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.network(url),
                  Positioned(
                    width: width * 0.85,
                    bottom: 15,
                    left: 0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          child: Text(mainHeading),
                        ),
                        Container(
                          color: Colors.white,
                          child: Text(subheading),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration:
                            InputDecoration(hintText: 'Enter Your Heading'),
                        onChanged: (value) {
                          setState(() {
                            mainHeading = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration:
                            InputDecoration(hintText: 'Enter Your Sub HEading'),
                        onChanged: (value) {
                          setState(() {
                            subheading = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
