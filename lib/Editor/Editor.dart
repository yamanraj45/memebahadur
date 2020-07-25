import 'dart:io';

import 'package:flutter/material.dart';

import 'DragItem.dart';

class Editor extends StatefulWidget {
  final File _imageselected;
  Editor(this._imageselected);
  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  List<DragItem> texts = [];

  _onAddTextPress(Offset offset) {
    setState(() {
      texts.add(
        DragItem(
          Offset.zero,
          "Add your text here",
          Colors.white,
          offset,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightMultiplier = 0.68;
    double width = MediaQuery.of(context).size.width;
    File _image = widget._imageselected;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                height: height * heightMultiplier,
                width: width,
                child: Stack(children: <Widget>[Image.file(_image)] + texts),
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
                  onPressed: () {
                    Offset offset = Offset(8, 58);
                    _onAddTextPress(offset);
                  },
                  label: Text('Add Text'),
                  icon: Icon(Icons.text_fields),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
