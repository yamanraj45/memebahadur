import 'dart:io';

import 'package:flutter/material.dart';

import './EditMenu.dart';

import 'package:image/image.dart' as img;

class Editor extends StatefulWidget {
  final File _imageselected;
  Editor(this._imageselected);
  @override
  EditorState createState() => EditorState(this._imageselected);
}

class EditorState extends State<Editor> {
  img.Image imagefilter;
  Image _imageWidget;

  EditorState(File image) {
    this.imagefilter = img.decodeImage(image.readAsBytesSync());
    this._imageWidget = Image.memory(img.encodeJpg(this.imagefilter));
  }

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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.68,
              width: MediaQuery.of(context).size.width,
              child: _imageWidget,
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        // color: Colors.green,
        color: Colors.black,
        child: EditMenu(),
      ),
    );
  }
}
