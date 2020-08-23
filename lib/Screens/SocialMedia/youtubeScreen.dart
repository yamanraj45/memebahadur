import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class YoutubeScreen extends StatefulWidget {
  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  String dislikeCount = "K";
  String likeCount = "M";
  String viewsCount = "B";
  String subscribercount = 'B';
  String title = 'Create Meme Share Happiness';
  String views = '45';
  String like = '45';
  String dislike = '45';
  String channelName = 'MemeBahadur';
  String subscriberCount = '45';
  final picker = ImagePicker();
  File videoImage;
  File _avatar;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                        child: videoImage != null
                            ? Image.file(videoImage)
                            : Image.asset('assets/icon/icon.png')),
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
                                        radius: 30.0,
                                        backgroundImage: FileImage(_avatar),
                                      )
                                    : Icon(Icons.add),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Use Form Below To Edit The Text Above'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
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
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red))),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('K'),
                                    value: 'K',
                                    groupValue: subscriberCount,
                                    onChanged: (value) {
                                      setState(() {
                                        subscriberCount = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('M'),
                                    value: 'M',
                                    groupValue: subscriberCount,
                                    onChanged: (value) {
                                      setState(() {
                                        subscriberCount = value;
                                      });
                                    }),
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
                              Expanded(
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
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red))),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('K'),
                                    value: 'K',
                                    groupValue: viewsCount,
                                    onChanged: (value) {
                                      setState(() {
                                        viewsCount = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('M'),
                                    value: 'M',
                                    groupValue: viewsCount,
                                    onChanged: (value) {
                                      setState(() {
                                        viewsCount = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('B'),
                                    value: 'B',
                                    groupValue: viewsCount,
                                    onChanged: (value) {
                                      setState(() {
                                        viewsCount = value;
                                      });
                                    }),
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
                              Expanded(
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
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red))),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('K'),
                                    value: 'K',
                                    groupValue: likeCount,
                                    onChanged: (value) {
                                      setState(() {
                                        likeCount = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('M'),
                                    value: 'M',
                                    groupValue: likeCount,
                                    onChanged: (value) {
                                      setState(() {
                                        likeCount = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('B'),
                                    value: 'B',
                                    groupValue: likeCount,
                                    onChanged: (value) {
                                      setState(() {
                                        likeCount = value;
                                      });
                                    }),
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
                              Expanded(
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
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red))),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('K'),
                                    value: 'K',
                                    groupValue: dislikeCount,
                                    onChanged: (value) {
                                      setState(() {
                                        dislikeCount = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('M'),
                                    value: 'M',
                                    groupValue: dislikeCount,
                                    onChanged: (value) {
                                      setState(() {
                                        dislikeCount = value;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    title: Text('B'),
                                    value: 'B',
                                    groupValue: dislikeCount,
                                    onChanged: (value) {
                                      setState(() {
                                        dislikeCount = value;
                                      });
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
            ],
          ),
        ),
      ),
    );
  }
}
