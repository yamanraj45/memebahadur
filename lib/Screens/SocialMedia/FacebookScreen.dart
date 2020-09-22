import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

class FacebookPost extends StatefulWidget {
  @override
  _FacebookPostState createState() => _FacebookPostState();
}

class _FacebookPostState extends State<FacebookPost> {
  bool _image = false;
  String _likes = '45';
  String _comment = '45';
  String _share = '45';
  bool _tag = true;
  String _firstPersononTagList = '45developers';
  String _nooftag = '45';
  String _status = 'Edit Status From Table Below';
  String _name = 'MemeBahadur';
  File _avatar;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    return MemeScaffold(
      child: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: new Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            radius: 20.0,
                            child: new Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('assets/images/logo.png'),
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
                              new Text('time'),
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
                            ? Image.asset('assets/images/logo.png')
                            : Container(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: new EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                child: Row(
                                  children: <Widget>[
                                    new CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Color(0xff3b5998),
                                      child: new Icon(
                                        Icons.thumb_up,
                                        size: 12.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    new CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Colors.red,
                                      child: new Icon(Icons.highlight_off),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 8.0),
                                      child: new Text('10'),
                                    ),
                                  ],
                                ),
                              ),
                              new Text(
                                '$_comment comments · $_share share',
                                style: TextStyle(fontSize: 13),
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
                                        Icon(Icons.add),
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
                                        Icon(Icons.add),
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
                                        Icon(Icons.add),
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
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Use Form Below To Edit'),
                        InputText(
                          onChanged: (value) {
                            setState(() {
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
                                        _name = value;
                                      });
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Container(
                                child: InputText(
                                    label: 'Comment', onChanged: null),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Container(
                                child:
                                    InputText(label: 'Share', onChanged: null),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: SwitchListTile(
                                title: Text('Image'),
                                value: _image,
                                onChanged: (value) {
                                  setState(() {
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
                                    _tag = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        _tag
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: InputText(
                                      label: 'First Person Tag',
                                      onChanged: (value) {
                                        setState(() {
                                          _firstPersononTagList = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: InputText(
                                        label: 'No of tag',
                                        onChanged: (value) {
                                          setState(() {
                                            _nooftag = value;
                                          });
                                        },
                                      )),
                                ],
                              )
                            : Container(),
                      ],
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
