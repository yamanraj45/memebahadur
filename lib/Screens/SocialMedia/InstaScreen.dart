import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:flutter/widgets.dart';

class InstaIcon {
  InstaIcon._();

  static const _kFontFam = 'InstaIcon';
  static const _kFontPkg = null;

  static const IconData like =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData comment =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData direct =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData save =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class InstaScreen extends StatefulWidget {
  @override
  _InstaScreenState createState() => _InstaScreenState();
}

enum ImageType { avatar, insta }

class _InstaScreenState extends State<InstaScreen> {
  String _username = 'MemeBahadur';
  bool _like = true;
  String _firstLiker = '45developers';
  String _totalLiker = '45';
  File _avatar;
  File _instaImage;
  bool isInstaEdited = false;
  final picker = ImagePicker();
  final previewContainer = GlobalKey();
  Future getImage(imageType, {source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      File path = File(pickedFile.path);
      setState(() {
        isInstaEdited = true;
        switch (imageType) {
          case ImageType.avatar:
            _avatar = path;
            break;
          case ImageType.insta:
            _instaImage = path;
            break;
          default:
            break;
        }
      });
    }
  }

  _showImagePicker(type) {
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
                      getImage(type, source: ImageSource.gallery);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(type, source: ImageSource.camera);
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
    onBackPress(context, flag: isInstaEdited);
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
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RepaintBoundary(
                  key: previewContainer,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(left: 10),
                                height: 40.0,
                                width: 40.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: GestureDetector(
                                  onTap: () => getImage(ImageType.avatar),
                                  child: _avatar != null
                                      ? CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage: FileImage(_avatar),
                                        )
                                      : CircleAvatar(
                                          foregroundColor: Colors.black,
                                          child: Icon(Icons.add),
                                        ),
                                ),
                              ),
                              new SizedBox(
                                width: 10.0,
                              ),
                              new Text(
                                _username,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          new IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: null,
                          )
                        ],
                      ),
                      Container(
                        child: ClipRRect(
                          child: _instaImage != null
                              ? GestureDetector(
                                  onTap: () =>
                                      _showImagePicker(ImageType.insta),
                                  child: Image.file(
                                    _instaImage,
                                  ),
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 60.0,
                                              child: Column(
                                                children: <Widget>[
                                                  RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    color: Colors.blue[300],
                                                    onPressed: () {
                                                      _showImagePicker(
                                                          ImageType.insta);
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  InstaIcon.like,
                                  size: 15,
                                ),
                                new SizedBox(
                                  width: 16.0,
                                ),
                                new Icon(
                                  InstaIcon.comment,
                                  size: 15,
                                ),
                                new SizedBox(
                                  width: 16.0,
                                ),
                                new Icon(
                                  InstaIcon.direct,
                                  size: 15,
                                ),
                              ],
                            ),
                            new Icon(
                              InstaIcon.save,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _like
                          ? Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Liked by $_firstLiker and $_totalLiker others",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Column(
                  children: <Widget>[
                    Text(
                      'Edit Table Below For Editing INSTA POST',
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: InputText(
                          label: 'Username',
                          maxLength: 25,
                          onChanged: (value) {
                            setState(() {
                              isInstaEdited = true;
                              _username = value;
                            });
                          }),
                    ),
                    SwitchListTile(
                      title: Text('Like Section'),
                      value: _like,
                      onChanged: (value) {
                        setState(() {
                          isInstaEdited = true;
                          _like = value;
                        });
                      },
                    ),
                    _like
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: InputText(
                                  onChanged: (value) {
                                    setState(() {
                                      _firstLiker = value;
                                    });
                                  },
                                  maxLength: 50,
                                  label: 'First Liker',
                                ),
                              ),
                              Expanded(
                                  child: InputText(
                                onChanged: (value) {
                                  setState(() {
                                    _totalLiker = value;
                                  });
                                },
                                label: 'Total Likes',
                              ))
                            ],
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
