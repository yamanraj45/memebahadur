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
  var _captionController = TextEditingController();
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

  @override
  dispose() {
    super.dispose();
    _captionController.dispose();
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
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    onBackPress(context, flag: isInstaEdited);
  }

  _onSavePress() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
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
      onSharePress: () {
        onSharePress(previewContainer);
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RepaintBoundary(
                  key: previewContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => getImage(ImageType.avatar),
                                    child: _avatar != null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              child: CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage:
                                                    FileImage(_avatar),
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            foregroundColor: Colors.black,
                                            child: Icon(Icons.add),
                                          ),
                                  ),
                                  new SizedBox(
                                    width: 10.0,
                                  ),
                                  new Text(
                                    _username,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      InstaIcon.like,
                                      size: 13,
                                    ),
                                    new SizedBox(
                                      width: 20,
                                    ),
                                    new Icon(
                                      InstaIcon.comment,
                                      size: 12,
                                    ),
                                    new SizedBox(
                                      width: 20,
                                    ),
                                    new Icon(
                                      InstaIcon.direct,
                                      size: 12,
                                    ),
                                  ],
                                ),
                                new Icon(
                                  InstaIcon.save,
                                  size: 13,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          _captionController.text.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: RichText(
                                    text: TextSpan(
                                        text: _username,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                '  ' + _captionController.text,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ]),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          _like
                              ? Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Liked by $_firstLiker and $_totalLiker others",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Edit Post',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: InputText(
                            label: 'Caption',
                            controller: _captionController,
                            maxLength: 250,
                            onChanged: (value) {
                              setState(() {
                                isInstaEdited = true;
                                // _caption = value;
                              });
                            }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _like
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .45,
                                  child: InputText(
                                    onChanged: (value) {
                                      setState(() {
                                        _firstLiker = value;
                                      });
                                    },
                                    maxLength: 50,
                                    label: 'Liked by',
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .45,
                                  child: InputText(
                                    onChanged: (value) {
                                      setState(() {
                                        _totalLiker = value;
                                      });
                                    },
                                    label: 'Total Likes',
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SwitchListTile(
                        title: Text('Show Likes on image'),
                        value: _like,
                        onChanged: (value) {
                          setState(() {
                            isInstaEdited = true;
                            _like = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
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
