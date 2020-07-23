import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memebahadur/Editor/Editor.dart';



class ContinueScreen extends StatefulWidget {
  final File _imageselected;
  ContinueScreen(this._imageselected);
  @override
  _ContinueScreenState createState() => _ContinueScreenState();
}

class _ContinueScreenState extends State<ContinueScreen> {
  @override
  Widget build(BuildContext context) {
    File image = widget._imageselected; // yesari access garne
    return Scaffold(
      appBar: AppBar(
        title: Text("Continue"),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Center(
            child:
                image == null ? Text("No Image Selected") : Image.file(image),
          ),
          RaisedButton(
            shape: CircleBorder(),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Editor(image)));
            },
            child: Icon(Icons.done),
            splashColor: Colors.red,
            textColor: Colors.white,
            color: image == null ? Colors.red : Colors.green,
          ),
        ],
      ),
  bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          
          elevation: 8.0,
          items:[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF3461eb),
            icon: Icon(Icons.save), title: Text('Save To Template')),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF3461eb),
            icon: Icon(Icons.save), title: Text('Save To Template')),
          
        ],

     ) );
  }
}
