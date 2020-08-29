import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

class Tweet extends StatefulWidget {
  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  String date;
  String time;
  final previewContainer = new GlobalKey();
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    var currentDate = DateTime.now();
    date = formatDate(currentDate);
    time = "00:00";
  }

  String platform = 'iPhone';
  String retweetcomment = '45';
  String likes = '45';
  String name = 'Meme Bahadur';
  String handle = '45developers';
  bool isImage = false;
  bool isTweetEdited = false;
  File _avatar;
  File twitterImage;
  final picker = ImagePicker();

  Future getAvatar() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      isTweetEdited = true;
      _avatar = File(pickedFile.path);
    });
  }

  Future getTwitterImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      isTweetEdited = true;
      twitterImage = File(pickedFile.path);
    });
  }

  String formatDate(date) {
    return DateFormat('dd MMM yyyy').format(date).toString();
  }

  String formatTime(time) {
    var hour = time.hour;
    var minute = time.minute;
    return ("${hour > 9 ? hour : '0' + hour.toString()}:${minute > 9 ? minute : '0' + minute.toString()}");
  }

  _onBackPress() {
    onBackPress(context, flag: isTweetEdited);
  }

  _onSavePress() {
    onSavePress(context, previewContainer);
  }

  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      onBackKeyPress: () {
        _onBackPress();
      },
      onBackPress: _onBackPress,
      onSavePress: _onSavePress,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                RepaintBoundary(
                  key: previewContainer,
                  child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () => getAvatar(),
                                      child: _avatar != null
                                          ? CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage:
                                                  FileImage(_avatar),
                                            )
                                          : CircleAvatar(
                                              foregroundColor: Colors.black,
                                              child: Icon(Icons.add),
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '$name',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      '@$handle',
                                                      style: TextStyle(
                                                        fontFamily: 'light',
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Expanded(
                                                child: Text('',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    maxLines: 1),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            TextField(
                              style: TextStyle(
                                fontFamily: 'bold',
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: 'What\'s happening?',
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.00),
                            ),
                            isImage
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: twitterImage != null
                                        ? Image.file(twitterImage)
                                        : Stack(
                                            children: <Widget>[
                                              Opacity(
                                                opacity: 0.2,
                                                child: Image.asset(
                                                  'assets/images/logo.png',
                                                ),
                                              ),
                                              CircleAvatar(
                                                foregroundColor: Colors.black,
                                                child: Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                  )
                                : Container(),
                            Padding(
                              padding: EdgeInsets.all(5.00),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[Text(time + ' · ')],
                                  ),
                                  Column(
                                    children: <Widget>[Text(date + ' · ')],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '\tTwitter For $platform',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(29, 161, 242, 1.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300],
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.00),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '$retweetcomment',
                                        style: TextStyle(
                                          fontFamily: 'Bold',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        ' Retweets and comments',
                                        style: TextStyle(
                                          fontFamily: 'light',
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '\t $likes',
                                        style: TextStyle(
                                          fontFamily: 'Bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        ' Likes',
                                        style: TextStyle(
                                          fontFamily: 'light',
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.00),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.mode_comment,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[Icon(Icons.repeat)],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(Icons.linked_camera)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[Icon(Icons.share)],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.00),
                            ),
                          ])),
                ),
                Padding(padding: EdgeInsets.all(30.00)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[]),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Edit The Picture Above With The Table Below',
                              style: TextStyle(
                                fontSize: 20.00,
                              ),
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  isTweetEdited = true;
                                  name = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Account Name',
                              ),
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  isTweetEdited = true;
                                  handle = value;
                                });
                              },
                              decoration:
                                  InputDecoration(hintText: 'Enter Username'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[],
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              child: Row(
                                children: <Widget>[
                                  Text('Image On Tweet '),
                                  Switch(
                                    onChanged: (value) {
                                      setState(() {
                                        isTweetEdited = true;
                                        isImage = value;
                                      });
                                    },
                                    value: isImage,
                                  )
                                ],
                              ),
                            ),
                            isImage
                                ? SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text('Camera'),
                                          onPressed: () => getTwitterImage(
                                              ImageSource.camera),
                                        ),
                                        RaisedButton(
                                          child: Text('Gallery'),
                                          onPressed: () => getTwitterImage(
                                              ImageSource.gallery),
                                        )
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[],
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    child: Text('Change Date'),
                                    onPressed: () => showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime(2500),
                                    ).then((value) {
                                      setState(() {
                                        isTweetEdited = true;
                                        if (value != null) {
                                          date = formatDate(value);
                                        }
                                      });
                                    }),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: RaisedButton(
                                      child: Text('Change Time'),
                                      onPressed: () => {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                hour: 12,
                                                minute: 00,
                                              ),
                                            ).then((value) {
                                              if (value != null) {
                                                setState(() {
                                                  isTweetEdited = true;
                                                  time = formatTime(value);
                                                });
                                              }
                                            })
                                          }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[],
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        isTweetEdited = true;
                                        retweetcomment = value;
                                      });
                                    },
                                    decoration:
                                        InputDecoration(hintText: 'Retweet'),
                                  ),
                                ),
                                Text('\t'),
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        isTweetEdited = true;
                                        likes = value;
                                      });
                                    },
                                    decoration:
                                        InputDecoration(hintText: ' Like'),
                                  ),
                                ),
                                Text('\t'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[],
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Android'),
                                Spacer(),
                                Flexible(
                                  child: RadioListTile(
                                      value: 'Android',
                                      groupValue: platform,
                                      onChanged: (value) {
                                        setState(() {
                                          isTweetEdited = true;
                                          platform = value;
                                        });
                                      }),
                                ),
                                Text('iPhone'),
                                Flexible(
                                  child: RadioListTile(
                                      value: 'iPhone',
                                      groupValue: platform,
                                      onChanged: (value) {
                                        setState(() {
                                          isTweetEdited = true;
                                          platform = value;
                                        });
                                      }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
