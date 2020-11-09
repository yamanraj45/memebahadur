import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:memebahadur/Screens/Template/TemplateScreen.dart';
import 'package:memebahadur/utils/Theme.dart';
import 'package:provider/provider.dart';

import 'Screens/SocialMedia/SocailmediaController.dart';

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
    final Size imageSize = ImageSizeGetter.getSize(FileInput(_imagePath));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Editor(image, imageSize)),
    );
  }

  int _currentIndex = 0;
  final navigationScreens = [Template(), SocialMediaHomepage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Dark Mode'),
                trailing: Consumer<ThemeNotifier>(
                  builder: (context, ThemeNotifier value, child) {
                    return Switch(
                      value: value.darkTheme,
                      onChanged: (theme) {
                        value.toggleTheme();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          leading: null,
          elevation: 1,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () => Navigator.of(context).pushNamed('/aboutus'),
            )
          ],
          title: Text(
            'Memebahadur',
            style: TextStyle(
                fontFamily: 'logo2',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: DoubleBackToCloseApp(
          child: IndexedStack(
            index: _currentIndex,
            children: <Widget>[Template(), SocialMediaHomepage()],
          ),
          snackBar: const SnackBar(
            content: Text('Tap back again to Exit The App'),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.black,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  title: Text('Social Medias'))
            ]),
        floatingActionButton: SpeedDial(
          curve: Curves.decelerate,
          overlayColor: Colors.transparent,
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
