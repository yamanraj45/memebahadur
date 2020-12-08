import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:memebahadur/Screens/MyFavorites/myfavoritecontroller.dart';
import 'package:memebahadur/Screens/Template/TemplateScreen.dart';
import 'package:memebahadur/Screens/TransitionScreen/transitionScreen.dart';
import 'package:memebahadur/utils/StateManagement/loginScreenState.dart';
import 'package:memebahadur/utils/image_converter.dart';
import 'package:memebahadur/utils/login_authentication.dart';
import 'package:memebahadur/utils/Theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;

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
      MaterialPageRoute(
          builder: (context) => TransitionScreen(image, imageSize)),
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
              rp.Consumer(
                builder: (context, watch, child) {
                  final user = watch(logincheckProvider).data?.value;
                  return DrawerHeader(
                    child: Center(
                      child: user != null
                          ? Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: CachedNetworkImage(
                                      imageUrl: user.photoURL,
                                      placeholder: (context, url2) => Center(
                                        child: CircularProgressIndicator(
                                            backgroundColor: Colors.red),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  user.displayName,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  user.email,
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            )
                          : Container(),
                    ),
                  );
                },
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
            ],
          ),
        ),
        appBar: AppBar(
          leading: null,
          backgroundColor: Colors.transparent,
          title: Text(
            'Memebahadur',
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
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
              MyFavoriteController(),
            ],
          ),
          snackBar: const SnackBar(
            content: Text('Tap back again to Exit The App'),
          ),
        ),
        bottomNavigationBar: CircleBottomNavigation(
            arcHeight: 20,
            circleSize: 40,
            circleOutline: 5,
            initialSelection: _currentIndex,
            onTabChangedListener: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: [
              TabData(icon: Icons.home, title: 'Home'),
              TabData(icon: Icons.add_circle_outline, title: 'Others'),
              TabData(icon: Icons.my_library_add_rounded, title: 'Templates')
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
                onTap: () => getImage(ImageSource.gallery).then((value) {
                      String imgString =
                          Utility.base64String(value.readAsByteSync());
                    }),
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.black)),
          ],
        ));
  }
}
