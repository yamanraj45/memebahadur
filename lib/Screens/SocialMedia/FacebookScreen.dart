import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:flutter/widgets.dart';

enum ImageType { avatar, photo }

class FbIcons {
  FbIcons._();

  static const _kFontFam = 'FbIcon';
  static const _kFontPkg = null;

  static const IconData comment =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData thumb =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData share =
      IconData(0xf064, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class FacebookPost extends StatefulWidget {
  @override
  _FacebookPostState createState() => _FacebookPostState();
}

class _FacebookPostState extends State<FacebookPost> {
  bool _image = false;
  String _likes = '45';
  String _comment = '45';
  String _share = '45';
  bool _tag = false;
  String time = 'weeks';
  String _firstPersononTagList = '45developers';
  String _nooftag = '45';
  String _status = 'Edit Status From Table Below';
  String _name = 'MemeBahadur';
  File _avatar;
  File _fbImage;
  String date = '';
  final picker = ImagePicker();
  var dateCleared = TextEditingController();
  var _commentController = TextEditingController();
  var _shareController = TextEditingController();

  Future getImage(imageType, {source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      File path = File(pickedFile.path);
      setState(() {
        switch (imageType) {
          case ImageType.avatar:
            _avatar = path;
            break;
          case ImageType.photo:
            _fbImage = path;
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
                      getImage(ImageType.photo, source: ImageSource.gallery);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageType.photo, source: ImageSource.camera);
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        });
  }

  bool isFbEdited = false;

  _onBackPress() {
    onBackPress(context, flag: isFbEdited);
  }

  final previewContainer = new GlobalKey();

  _onSavePress() {
    onSavePress(context, previewContainer);
  }

  @override
  void initState() {
    super.initState();
    _shareController.text = '0';
    _commentController.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      onBackKeyPress: () {
        _onBackPress();
      },
      onBackPress: _onBackPress,
      onSavePress: _onSavePress,
      onSharePress: () {
        onSharePress(previewContainer);
      },
      child: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  RepaintBoundary(
                    key: previewContainer,
                    child: Card(
                      child: new Column(
                        children: <Widget>[
                          ListTile(
                            leading: GestureDetector(
                              onTap: () => getImage(ImageType.avatar),
                              child: _avatar != null
                                  ? CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: FileImage(_avatar),
                                    )
                                  : CircleAvatar(
                                      foregroundColor: Colors.black,
                                      child: Icon(Icons.add),
                                    ),
                            ),
                            title: RichText(
                              text: TextSpan(
                                  text: _name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: _tag
                                      ? <TextSpan>[
                                          TextSpan(
                                            text: ' is with',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                          TextSpan(
                                            text: ' $_firstPersononTagList',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' and',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                          TextSpan(
                                            text: ' $_nooftag others',
                                          ),
                                        ]
                                      : <TextSpan>[
                                          TextSpan(
                                            text: '',
                                          ),
                                        ]),
                            ),
                            subtitle: new Row(
                              children: [
                                time != 'few seconds'
                                    ? Text('$date $time ago')
                                    : Text('$time ago'),
                                new Icon(
                                  Icons.public,
                                  size: 15.0,
                                )
                              ],
                            ),
                            trailing: new Icon(Icons.more_horiz),
                          ),
                          ListTile(
                            title: Text(_status),
                          ),
                          _image
                              ? Container(
                                  child: _fbImage != null
                                      ? GestureDetector(
                                          onTap: () => _showImagePicker(),
                                          child: Container(
                                              child: Image.file(_fbImage)),
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
                                                              color:
                                                                  Colors.black,
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: new EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  child: _likes == '0'
                                      ? Text('')
                                      : Row(
                                          children: <Widget>[
                                            new CircleAvatar(
                                              radius: 10.0,
                                              backgroundColor: Colors.blue[700],
                                              child: new Icon(
                                                Icons.thumb_up,
                                                size: 12.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            new Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0.0,
                                                      horizontal: 8.0),
                                              child: new Text(_likes),
                                            ),
                                          ],
                                        ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: _commentController.text != '0'
                                          ? _commentController.text +
                                              ' comments'
                                          : '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: _shareController.text != '0'
                                              ? ' . ' +
                                                  _shareController.text +
                                                  ' shares'
                                              : '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(FbIcons.thumb,
                                              color: Colors.grey),
                                          Text('Like'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(FbIcons.comment,
                                              color: Colors.grey),
                                          Text('Comment'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            FbIcons.share,
                                            color: Colors.grey,
                                          ),
                                          Text('Share'),
                                        ],
                                      ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Use Form Below To Edit'),
                          InputText(
                            onChanged: (value) {
                              setState(() {
                                isFbEdited = true;
                                _name = value;
                              });
                            },
                            multiline: true,
                            label: "Name",
                            maxLength: 75,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputText(
                            onChanged: (value) {
                              setState(() {
                                isFbEdited = true;
                                _status = value;
                              });
                            },
                            multiline: true,
                            label: "Status",
                            maxLength: 230,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Container(
                                  child: InputText(
                                      label: 'Like',
                                      onChanged: (value) {
                                        setState(() {
                                          isFbEdited = true;
                                          _likes = value;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Container(
                                  child: InputText(
                                      controller: _commentController,
                                      label: 'Comment',
                                      onChanged: (value) {
                                        setState(() {
                                          isFbEdited = true;
                                          _comment = value;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Container(
                                  child: InputText(
                                      controller: _shareController,
                                      label: 'Share',
                                      onChanged: (value) {
                                        setState(() {
                                          isFbEdited = true;
                                          _share = value;
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              time != 'few seconds'
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: InputText(
                                        onChanged: (value) {
                                          setState(() {
                                            date = value;
                                          });
                                        },
                                        label: "Time",
                                      ),
                                    )
                                  : Container(),
                              Container(
                                child: DropdownButton(
                                  hint: Text('Time'),
                                  value: time,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('few seconds'),
                                      value: 'few seconds',
                                      onTap: () {
                                        setState(() {
                                          print(dateCleared.text);
                                        });
                                      },
                                    ),
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
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _tag
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: InputText(
                                        label: 'First Person Tag',
                                        maxLength: 30,
                                        onChanged: (value) {
                                          setState(() {
                                            isFbEdited = true;
                                            _firstPersononTagList = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: InputText(
                                          label: 'No of tag',
                                          onChanged: (value) {
                                            setState(() {
                                              isFbEdited = true;
                                              _nooftag = value;
                                            });
                                          },
                                        )),
                                  ],
                                )
                              : Container(),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: SwitchListTile(
                                  title: Text('Image'),
                                  value: _image,
                                  onChanged: (value) {
                                    setState(() {
                                      isFbEdited = true;
                                      _image = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: SwitchListTile(
                                  title: Text('Tag'),
                                  value: _tag,
                                  onChanged: (value) {
                                    setState(() {
                                      isFbEdited = true;
                                      _tag = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
