import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:memebahadur/Screens/Template/TemplateScreen.dart';

class NavigationBar extends StatefulWidget {
  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
    });
    // TODO: DISPLAY LOADING SCREEN
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Editor(this._image)));
  }

  int _currentIndex = 0;
  final List<Widget> _navigator = [
    Template(),
    Template(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DoubleBackToCloseApp(
          child: _navigator[_currentIndex],
          snackBar: const SnackBar(
            content: Text('Tap back again to Exit The App'),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                title: Text('All Template'), icon: Icon(Icons.border_all)),
            BottomNavigationBarItem(
                icon: Icon(Icons.save), title: Text('My Meme'))
          ],
        ),
        floatingActionButton: SpeedDial(
          foregroundColor: Colors.white,
          overlayColor: Color(0xFF5c7066),
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF3461eb),
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera),
              backgroundColor: Colors.red,
              label: 'Camera',
              onTap: () => getImage(ImageSource.camera),
              labelStyle: TextStyle(fontSize: 18.0),
            ),
            SpeedDialChild(
              child: Icon(Icons.photo_library),
              backgroundColor: Colors.red,
              label: 'Gallery',
              onTap: () => getImage(ImageSource.gallery),
              labelStyle: TextStyle(fontSize: 18.0),
            ),
          ],
        ));
  }
}
