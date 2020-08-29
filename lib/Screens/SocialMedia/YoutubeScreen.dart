import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

class YoutubeScreen extends StatefulWidget {
  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  final GlobalKey previewContainer = new GlobalKey();
  String dislikeCount = "K";
  String likeCount = "M";
  String viewsCount = "B";
  String subscribernumcount = 'B';
  String title = 'Create Meme Share Happiness';
  String views = '45';
  String like = '45';
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
                      GestureDetector(
                        child: videoImage != null
                            ? Image.file(videoImage)
                            : Opacity(
                                opacity: 0.2,
                                child: Image.asset('assets/images/logo.png'),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      Text(
                        "   $views$viewsCount views \t 4 weeks ago",
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
                              Icon(Icons.add),
                              Icon(Icons.add_to_photos),
                              Icon(Icons.screen_share),
                              Icon(Icons.archive),
                              Icon(Icons.add_to_photos)
                            ],
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              '\t$like$likeCount',
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              '\t\t\t\t\t\t$dislike$dislikeCount',
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              '\t\t\t\t\tShare',
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              '\t\tDownload',
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              'Save',
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                      ),
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
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        '  $channelName',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            '$subscriberCount Subscriber',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                'Subscribe',
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
              Text(
                'Use Form Below To Edit The Text Above',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Gallery'),
                            onPressed: () => getVideoImage(ImageSource.gallery),
                          ),
                          RaisedButton(
                            onPressed: () => getVideoImage(ImageSource.camera),
                            child: Text('Camera'),
                          )
                        ],
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
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            channelName = value;
                          });
                        },
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
                                      MediaQuery.of(context).size.width * 0.41,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        like = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
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
                                  child: DropdownButton(
                                    hint: Text(''),
                                    value: subscribernumcount,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('K'),
                                        value: 'K',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('M'),
                                        value: 'M',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('B'),
                                        value: 'B',
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        subscribernumcount = value;
                                      });
                                    },
                                  ),
                                )
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
                                      MediaQuery.of(context).size.width * 0.41,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        like = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
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
                                Spacer(),
                                DropdownButton(
                                  hint: Text(''),
                                  value: viewsCount,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('K'),
                                      value: 'K',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('M'),
                                      value: 'M',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('B'),
                                      value: 'B',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      viewsCount = value;
                                    });
                                  },
                                )
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
                                      MediaQuery.of(context).size.width * 0.41,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        like = value;
                                      });
                                    },
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
                                DropdownButton(
                                  hint: Text(''),
                                  value: likeCount,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('K'),
                                      value: 'K',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('M'),
                                      value: 'M',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('B'),
                                      value: 'B',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      likeCount = value;
                                    });
                                  },
                                )
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
                                      MediaQuery.of(context).size.width * 0.41,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        like = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
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
                                Spacer(),
                                DropdownButton(
                                  hint: Text(''),
                                  value: dislikeCount,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('K'),
                                      value: 'K',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('M'),
                                      value: 'M',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('B'),
                                      value: 'B',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      dislikeCount = value;
                                    });
                                  },
                                )
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
