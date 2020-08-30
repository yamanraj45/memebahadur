import 'package:flutter/material.dart';
import 'package:memebahadur/NavigationBar.dart';
import 'package:memebahadur/Screens/AboutUs/aboutus.dart';
import 'package:memebahadur/utils/Theme.dart';
import 'package:memebahadur/Screens/SocialMedia/TwitterScreen.dart';
import 'package:memebahadur/Screens/SocialMedia/YoutubeScreen.dart';
import 'package:memebahadur/utils/path.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:memebahadur/utils/permissions.dart';

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
    PathUtils.getDataDir();
    askPermissions();
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: notifier.darkTheme ? light : dark,
          title: 'MemeBahadur',
          home: SplashScreen(
            seconds: 1,
            navigateAfterSeconds: NavigationBar(),
            image: Image.asset('assets/images/logo.png'),
            photoSize: 200,
            backgroundColor: Colors.black,
            loaderColor: Colors.grey,
            styleTextUnderTheLoader: TextStyle(
              backgroundColor: Colors.black,
              color: Colors.white,
            ),
            loadingText: Text(
              'Getting Things Ready',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => NavigationBar(),
            '/aboutus': (BuildContext context) => AboutUs(),
            '/tweet': (BuildContext context) => Tweet(),
            '/youtubescreen': (BuildContext context) => YoutubeScreen(),
          },
        );
      }),
    );
  }
}
