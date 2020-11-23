import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:memebahadur/Screens/MyFavorites/myFavorite.dart';
import 'package:memebahadur/Screens/Template/TemplateScreen.dart';
import 'package:memebahadur/utils/StateManagement/loginScreenState.dart';
import 'package:memebahadur/utils/login_authentication.dart';
import 'package:memebahadur/utils/Theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:wiredash/wiredash.dart';

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
              DrawerHeader(
                child: Center(
                  child: ClipRRect(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
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
              ),
              ListTile(
                title: Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/aboutus');
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  AuthenticationService.logout(context);
                },
              ),
              ListTile(
                title: Text('Connect With Us'),
                onTap: () {
                  Wiredash.of(context).show();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: null,
          elevation: 1,
          backgroundColor: Colors.transparent,
          title: Text(
            'Memebahadur',
            style: TextStyle(
              fontFamily: 'logo2',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: DoubleBackToCloseApp(
          child: IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              Template(),
              SocialMediaHomepage(),
              MyFavorites()
            ],
          ),
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
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                title: Text('Other '),
              )
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
