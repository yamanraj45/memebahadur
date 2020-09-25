import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

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
  final picker = ImagePicker();
  Future getImage(imageType, {source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      File path = File(pickedFile.path);
      setState(() {
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

  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
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
                                onTap: () => _showImagePicker(ImageType.avatar),
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
                                onTap: () => _showImagePicker(ImageType.insta),
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
                                            backgroundColor: Colors.transparent,
                                            radius: 60.0,
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
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
                              Icon(Icons.favorite),
                              new SizedBox(
                                width: 16.0,
                              ),
                              new Icon(
                                FontAwesomeIcons.comment,
                              ),
                              new SizedBox(
                                width: 16.0,
                              ),
                              new Icon(FontAwesomeIcons.paperPlane),
                            ],
                          ),
                          new Icon(FontAwesomeIcons.bookmark)
                        ],
                      ),
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
                              _username = value;
                            });
                          }),
                    ),
                    SwitchListTile(
                      title: Text('Like Section'),
                      value: _like,
                      onChanged: (value) {
                        setState(() {
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
