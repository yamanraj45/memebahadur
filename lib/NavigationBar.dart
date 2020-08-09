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
  File _imagePath;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _imagePath = File(pickedFile.path);
    });
    Image image = Image.file(_imagePath);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Editor(image)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              color: Colors.cyanAccent,
              onPressed: () => Navigator.of(context).pushNamed('/aboutus'),
            )
          ],
          title: Text('MemeBahadur',
              style: TextStyle(
                  fontFamily: 'logo2',
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent)),
          centerTitle: true,
        ),
        body: DoubleBackToCloseApp(
          child: Template(),
          snackBar: const SnackBar(
            content: Text('Tap back again to Exit The App'),
          ),
        ),
        floatingActionButton: SpeedDial(
          child: Icon(Icons.add),
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera),
              label: 'Camera',
              onTap: () => getImage(ImageSource.camera),
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            SpeedDialChild(
                child: Icon(Icons.photo_library),
                label: 'Gallery',
                onTap: () => getImage(ImageSource.gallery),
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.black)),
          ],
        ));
  }
}
