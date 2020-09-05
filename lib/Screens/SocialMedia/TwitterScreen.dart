import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:flutter/widgets.dart';

class TwitterIcon {
  TwitterIcon._();

  static const _kFontFam = 'twittericon';
  static const _kFontPkg = null;

  static const IconData verified =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData comment =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData retweet =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData like =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

enum ImageType { avatar, twitter }

class Tweet extends StatefulWidget {
  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    var currentDate = DateTime.now();
    date = formatDate(currentDate);
    time = "00:00";
  }

  final previewContainer = new GlobalKey();
  String date;
  String time;
  String tweet = '';
  String platform = 'iPhone';
  String retweetcomment = '45';
  String likes = '45';
  String name = 'Meme Bahadur';
  String handle = '45developers';
  bool isImage = false;
  bool isVerified = true;
  bool isTweetEdited = false;
  File _avatar;
  File _twitterImage;
  final picker = ImagePicker();

  Future getImage(imageType, {source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      File path = File(pickedFile.path);
      setState(() {
        isTweetEdited = true;
        switch (imageType) {
          case ImageType.avatar:
            _avatar = path;
            break;
          case ImageType.twitter:
            _twitterImage = path;
            break;
          default:
            break;
        }
      });
    }
  }

  _showImagePicker() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose:"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Divider(),
                  ListTile(
                    title: Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageType.twitter, source: ImageSource.gallery);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageType.twitter, source: ImageSource.camera);
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
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
                                      onTap: () => getImage(ImageType.avatar),
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
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          name,
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        isVerified
                                                            ? Icon(
                                                                TwitterIcon
                                                                    .verified,
                                                                size: 18,
                                                                color: Colors
                                                                        .lightBlueAccent[
                                                                    400],
                                                              )
                                                            : Container()
                                                      ],
                                                    ),
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
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              tweet,
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            isImage
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: _twitterImage != null
                                        ? GestureDetector(
                                            onTap: () => _showImagePicker(),
                                            child: Image.file(_twitterImage),
                                          )
                                        : Stack(
                                            children: <Widget>[
                                              Opacity(
                                                opacity: 0,
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/images/logo.png',
                                                  ),
                                                ),
                                              ),
                                              Positioned.fill(
                                                bottom: 30.0,
                                                child: Container(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    minRadius: 50.00,
                                                    maxRadius: 80.00,
                                                    child: ClipRect(
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 60.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            RaisedButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0),
                                                              ),
                                                              color: Colors
                                                                  .blue[300],
                                                              onPressed: () {
                                                                _showImagePicker();
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                                size: 50.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                                        TwitterIcon.comment,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(TwitterIcon.retweet)
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[Icon(TwitterIcon.like)],
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
                // Padding(padding: EdgeInsets.all(30.00)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(
                        color: Colors.black,
                      ),
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: <Widget>[]),
                      Text(
                        'Edit Tweet',
                        style: TextStyle(
                          fontSize: 30.00,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InputText(
                                            onChanged: (value) {
                                              setState(() {
                                                isTweetEdited = true;
                                                name = value;
                                              });
                                            },
                                            label: "Account",
                                            maxLength: 20,
                                          ),
                                        ),
                                        Icon(TwitterIcon.verified),
                                        Switch(
                                          onChanged: (value) {
                                            setState(() {
                                              isVerified = value;
                                              print(value);
                                            });
                                          },
                                          value: isVerified,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.00),
                            ),
                            InputText(
                                onChanged: (value) {
                                  setState(() {
                                    isTweetEdited = true;
                                    handle = value;
                                  });
                                },
                                maxLength: 15,
                                label: "Username"),
                            Padding(
                              padding: EdgeInsets.all(5.00),
                            ),
                            InputText(
                              onChanged: (value) {
                                setState(() {
                                  isTweetEdited = true;
                                  tweet = value;
                                });
                              },
                              multiline: true,
                              label: "Tweet",
                              maxLength: 230,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.00),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.date_range),
                                            Text(" Date")
                                          ],
                                        ),
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
                                  ),
                                  Spacer(),
                                  Container(
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.timer),
                                            Text(" Time")
                                          ],
                                        ),
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
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 30,
                                      ),
                                      Switch(
                                        onChanged: (value) {
                                          setState(() {
                                            isTweetEdited = true;
                                            isImage = value;
                                          });
                                        },
                                        value: isImage,
                                      ),
                                    ],
                                  ),
                                  // Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: InputText(
                                    onChanged: (value) {
                                      setState(() {
                                        isTweetEdited = true;
                                        retweetcomment = value;
                                      });
                                    },
                                    label: "Retweets",
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 6,
                                  child: InputText(
                                    label: "Likes",
                                    onChanged: (value) {
                                      setState(() {
                                        isTweetEdited = true;
                                        likes = value;
                                      });
                                    },
                                  ),
                                ),
                                Text('\t'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: RadioListTile(
                                  title: Text("Android"),
                                  value: 'Android',
                                  groupValue: platform,
                                  onChanged: (value) {
                                    setState(() {
                                      isTweetEdited = true;
                                      platform = value;
                                    });
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  title: Text('iPhone'),
                                  value: 'iPhone',
                                  groupValue: platform,
                                  onChanged: (value) {
                                    setState(() {
                                      isTweetEdited = true;
                                      platform = value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
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
