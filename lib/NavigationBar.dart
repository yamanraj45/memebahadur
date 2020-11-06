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
  final navigationScreens = [Template(), SocialMediaHomepage(), MyFavorites()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            children: <Widget>[
              Consumer<User>(
                builder: (context, watch, child) => Text('Hello'),
              ),
              DrawerHeader(
                child: Center(
                  child: ClipRRect(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              ListTile(
                title: Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
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
              color: Colors.black,
              onPressed: () => Navigator.of(context).pushNamed('/aboutus'),
            ),
            IconButton(
              icon: Icon(Icons.info),
              color: Colors.red,
              onPressed: () async {
                await AuthenticationService.logout();
              },
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
            elevation: 1,
            unselectedItemColor: Colors.black45,
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
                title: Text('Social Medias'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('My Favorites'),
              ),
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
