import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

class YoutubeIcon {
  YoutubeIcon._();

  static const _kFontFam = 'AppIcons';
  static const _kFontPkg = null;

  static const IconData like =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dislike =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData save =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData share =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class YoutubeScreen extends StatefulWidget {
  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  final GlobalKey previewContainer = new GlobalKey();
  String dislikeCount = "K";

  String title = 'Create Meme Share Happiness';
  String views = '45B';
  String like = '45M';
  String dislike = '45';
  String channelName = 'MemeBahadur';
  String subscriberCount = '45';
  final picker = ImagePicker();
  File videoImage;
  File _avatar;
  String postedTime = '4';
  String videopostedTime = 'weeks';

  Future getVideoImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      videoImage = File(pickedFile.path);
    });
  }

  _showImagePicker() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("From where do you want to take the photo?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      getVideoImage(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      getVideoImage(ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future getAvatar() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _avatar = File(pickedFile.path);
    });
  }

  _onBackPress() {
    onBackPress(context, flag: false);
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
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RepaintBoundary(
                key: previewContainer,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: videoImage != null
                            ? GestureDetector(
                                onTap: () => _showImagePicker(),
                                child: Image.file(videoImage),
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
                                        backgroundColor: Colors.transparent,
                                        minRadius: 50.00,
                                        maxRadius: 80.00,
                                        child: ClipRect(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 60.0,
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0)),
                                                  color: Colors.blue[300],
                                                  onPressed: () {
                                                    _showImagePicker();
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
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
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.00),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  '  $title',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      Text(
                        "   $views views \t $postedTime $videopostedTime ago",
                        style: TextStyle(fontSize: 13),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.00),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50.00,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Icon(
                                    YoutubeIcon.dislike,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    '$like',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    YoutubeIcon.like,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    '$dislike',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    YoutubeIcon.share,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.file_download,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    YoutubeIcon.save,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.all(5.00),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => getAvatar(),
                                  child: _avatar != null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 20.0,
                                          backgroundImage: FileImage(_avatar),
                                        )
                                      : Opacity(
                                          opacity: 0.5,
                                          child: CircleAvatar(
                                            radius: 20.0,
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      child: Text(
                                        '$channelName',
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '$subscriberCount suscribers',
                                        style: TextStyle(
                                          fontFamily: 'light',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          SizedBox(),
                          Row(
                            children: <Widget>[
                              Text(
                                'SUBSCRIBE',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Use Form Below To Edit The Text Above',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Title ',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            channelName = value;
                          });
                        },
                        maxLength: 25,
                        decoration: InputDecoration(
                            hintText: 'Enter Channel Name ',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.36,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        subscriberCount = value;
                                      });
                                    },
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                        hintText: 'Subscriber',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red))),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.36,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        views = value;
                                      });
                                    },
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                        hintText: 'Views',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red))),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.36,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        like = value;
                                      });
                                    },
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                        hintText: 'Like',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red))),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.36,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        dislike = value;
                                      });
                                    },
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                        hintText: 'DisLike',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red))),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.41,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        postedTime = value;
                                      });
                                    },
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: 'Time',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red))),
                                  ),
                                ),
                                Spacer(),
                                DropdownButton(
                                  hint: Text(''),
                                  value: videopostedTime,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('hours'),
                                      value: 'hour',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('days'),
                                      value: 'days',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('weeks'),
                                      value: 'weeks',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('months'),
                                      value: 'months',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('years'),
                                      value: 'years',
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      videopostedTime = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
