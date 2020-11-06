import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/widgets/InputText.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String mainHeading = 'Main Heading Section';
  String subheading = 'Enter Subheading Here';
  File _newsImage;
  final picker = ImagePicker();
  final url =
      'https://drive.google.com/uc?export=view&id=112jcK61HSBZ6Jc8pMf6qWVk7nT9Ld4Xv';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File path = File(pickedFile.path);
        setState(() {
          _newsImage = path;
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  _newsImage != null
                      ? Image.file(_newsImage)
                      : Image.network(url),
                  Positioned(
                    width: screenWidth,
                    bottom: 15,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 5),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: screenWidth * 0.89,
                                height: 27,
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    mainHeading,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset('assets/icon/icon.png'))
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: screenWidth * 0.81,
                                color: Colors.white,
                                child: Text(subheading),
                              ),
                              Container(
                                color: Colors.black,
                                child: Text(
                                  '11:00 PM',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      InputText(
                        maxLength: 50,
                        label: 'Enter Heading',
                        onChanged: (value) {
                          setState(() {
                            mainHeading = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InputText(
                        maxLength: 49,
                        label: 'Enter Subeading',
                        onChanged: (value) {
                          setState(() {
                            subheading = value;
                          });
                        },
                      ),
                      RaisedButton(
                        onPressed: () => getImage(),
                        child: Text('Pick Image'),
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
