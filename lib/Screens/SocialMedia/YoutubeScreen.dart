import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

enum ImageType { avatar, youtube }

class YoutubeIcon {
  YoutubeIcon._();

  static const _kFontFam = 'AppIcons';
  static const _kFontPkg = null;

  static const IconData likes =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dislikes =
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
  String likes = '45M';
  String dislikes = '45';
  String channel = 'MemeBahadur';
  String subscribers = '45';
  final picker = ImagePicker();
  File _image;
  File _avatar;
  String date = '4';
  String time = 'weeks';
  bool isYoutubeEdited = false;

  Future getImage(imageType, {source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      File path = File(pickedFile.path);
      setState(() {
        isYoutubeEdited = true;
        switch (imageType) {
          case ImageType.avatar:
            _avatar = path;
            break;
          case ImageType.youtube:
            _image = path;
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
                      getImage(ImageType.youtube, source: ImageSource.gallery);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageType.youtube, source: ImageSource.camera);
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
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
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    return MemeScaffold(
      onBackKeyPress: () {
        _onBackPress();
      },
      onBackPress: _onBackPress,
      onSavePress: _onSavePress,
      onSharePress: () {
        onSharePress(previewContainer);
      },
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RepaintBoundary(
                key: previewContainer,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: _image != null
                            ? GestureDetector(
                                onTap: () => _showImagePicker(),
                                child: Center(child: Image.file(_image)),
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
                                      child: Center(
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
                              SizedBox(
                                width: screenWidth * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 10),
                                  child: Text(
                                    '$title',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      Text(
                        "   $views views \t $date $time ago",
                        style: TextStyle(fontSize: 13),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.00),
                      ),
                      SizedBox(
                          height: 50.00,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Icon(YoutubeIcon.dislikes,
                                      color: Colors.grey[600]),
                                  Text(
                                    '$likes',
                                    style: TextStyle(color: Colors.grey[600]),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(YoutubeIcon.likes,
                                      color: Colors.grey[600]),
                                  Text(
                                    '$dislikes',
                                    style: TextStyle(color: Colors.grey[600]),
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
                                    Icons.add_to_photos,
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
                                  onTap: () => getImage(ImageType.avatar),
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
                                        '  $channel',
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '  $subscribers suscribers',
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
              Padding(padding: EdgeInsets.all(10)),
              Text(
                '   Edit YouTube',
                style: TextStyle(
                  fontSize: 20.00,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(5.0)),
                      InputText(
                          label: "Title",
                          maxLength: null,
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          }),
                      Padding(padding: EdgeInsets.all(5.0)),
                      InputText(
                          maxLength: 20,
                          label: "Channel",
                          onChanged: (value) {
                            setState(() {
                              channel = value;
                            });
                          }),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                    width: screenWidth * 0.5,
                                    child: InputText(
                                        label: "Subscribers",
                                        onChanged: (value) {
                                          setState(() {
                                            subscribers = value;
                                          });
                                        })),
                                Spacer(),
                                SizedBox(
                                    width: screenWidth * 0.5,
                                    child: InputText(
                                        label: "Views",
                                        onChanged: (value) {
                                          setState(() {
                                            views = value;
                                          });
                                        })),
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(5.0)),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                    width: screenWidth * 0.5,
                                    child: InputText(
                                        label: "Likes",
                                        onChanged: (value) {
                                          setState(() {
                                            likes = value;
                                          });
                                        })),
                                Spacer(),
                                SizedBox(
                                  width: screenWidth * 0.5,
                                  child: InputText(
                                      label: "Dislikes",
                                      onChanged: (value) {
                                        setState(() {
                                          dislikes = value;
                                        });
                                      }),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(5.0)),
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
                                  width: screenWidth * 0.5,
                                  child: InputText(
                                    onChanged: (value) {
                                      setState(() {
                                        date = value;
                                      });
                                    },
                                    label: "Time",
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: DropdownButton(
                                    hint: Text('Time'),
                                    value: time,
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
                                        time = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(20))
            ],
          ),
        ),
      ),
    );
  }
}
