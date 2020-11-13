import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:memebahadur/widgets/MemeTextInput.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final GlobalKey previewContainer = new GlobalKey();
  String mainHeading = 'Main Heading Section';
  String time = '11:00';
  String subheading = 'Enter Subheading Here';
  File _newsImage;
  bool _isNewsEdited = false;
  final picker = ImagePicker();
  final url1 =
      'https://drive.google.com/uc?export=view&id=1lNQr9zEh9DxcnEAVswgeecFm8oD-nJxt';
  final url2 =
      'https://drive.google.com/uc?export=view&id=10yEupKbm2VEWQiLEZgLgcwWVQK-_hl7l';
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

    _onBackPress() {
      onBackPress(context, flag: _isNewsEdited);
    }

    _onSavePress() {
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      onSavePress(context, previewContainer);
    }

    _onSharePress() async {
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        takeScreenshot(previewContainer).then((filename) {
          Share.file("MemeBahadur", "memebahadur.jpg",
              File(filename).readAsBytesSync(), "image/jpg");
        });
      });
    }

    String formatTime(time) {
      var hour = time.hour;
      var minute = time.minute;
      print(hour + minute);
      return ("${hour > 9 ? hour : '0' + hour.toString()}:${minute > 9 ? minute : '0' + minute.toString()}");
    }

    return MemeScaffold(
      onBackKeyPress: () {
        _onBackPress();
      },
      onBackPress: _onBackPress,
      onSavePress: _onSavePress,
      onSharePress: _onSharePress,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RepaintBoundary(
                key: previewContainer,
                child: Container(
                  padding: const EdgeInsets.all(9),
                  child: Stack(
                    children: <Widget>[
                      _newsImage != null
                          ? Image.file(_newsImage)
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.31,
                              width: screenWidth,
                              child: CachedNetworkImage(
                                imageUrl: url2,
                                placeholder: (context, url2) => Center(
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.red),
                                ),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                      Positioned(
                        width: screenWidth,
                        bottom: 15,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.82,
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
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                      height: 30,
                                      width: 30,
                                      child:
                                          Image.asset('assets/icon/icon.png'))
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: screenWidth * 0.80,
                                    color: Colors.white,
                                    child: Text(
                                      subheading,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  Container(
                                    color: Colors.black,
                                    child: Text(
                                      time,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
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
                        label: 'Enter Sub-heading',
                        onChanged: (value) {
                          setState(() {
                            subheading = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => getImage(),
                            child: Text('Pick Image'),
                          ),
                          RaisedButton(
                            onPressed: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: 12,
                                  minute: 00,
                                ),
                              ).then(
                                (value) {
                                  print(time);
                                  if (value != null) {
                                    setState(
                                      () {
                                        time = formatTime(value);
                                        print(time);
                                      },
                                    );
                                  }
                                },
                              );
                            },
                            child: Text('Change Time'),
                          ),
                        ],
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
