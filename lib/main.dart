import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/Editor/Editor.dart';

import 'package:memebahadur/home_page.dart';
import 'package:memebahadur/template/maintemplate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Navigators(),
      routes: <String, WidgetBuilder>{
        '/templates': (BuildContext context) => TemplateHome(),
        '/home': (BuildContext context) => HomePage(),
      },
    );
  }
}

class Navigators extends StatefulWidget {
  @override
  _NavigatorsState createState() => _NavigatorsState();
}

class _NavigatorsState extends State<Navigators> {
  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Editor(this._image)));
  }

  int _currentIndex = 0;
  final List<Widget> _navigator = [
    TemplateHome(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigator[_currentIndex],
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
          SpeedDialChild(
            child: Icon(Icons.cloud_download),
            backgroundColor: Colors.red,
            label: 'Template',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Navigator.of(context).pushNamed('/templates'),
          ),
        ],
      ),
    );
  }
}
