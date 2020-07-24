import 'dart:io';

import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  final File _imageselected;
  Editor(this._imageselected);
  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    File _image = widget._imageselected;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Screen"),
        actions: <Widget>[
          FlatButton(child: Icon(Icons.save), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.00),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.68,
                width: MediaQuery.of(context).size.width,
                child: Image.file(_image),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton.icon(
                  padding: EdgeInsets.all(18.00),
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blueAccent)),
                  onPressed: () {},
                  label: Text('Add Text'),
                  icon: Icon(Icons.text_fields),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: MediaQuery.of(context).size.height * 0.08,
      //   width: MediaQuery.of(context).size.width,
      //   // color: Colors.green,
      //   color: Colors.black,
      //   child: EditMenu(),
      // ),
    );
  }
}
