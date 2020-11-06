import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:memebahadur/NavigationBar.dart';
import 'package:memebahadur/Screens/AboutUs/aboutus.dart';
import 'package:memebahadur/Screens/Login/loginscreen.dart';
import 'package:memebahadur/Screens/SocialMedia/FacebookScreen.dart';
import 'package:memebahadur/Screens/SocialMedia/GoogleDidYouMean.dart';
import 'package:memebahadur/Screens/SocialMedia/GoogleTranslate.dart';

import 'package:memebahadur/Screens/SocialMedia/InstaScreen.dart';

import 'package:memebahadur/Screens/SocialMedia/TwitterScreen.dart';
import 'package:memebahadur/Screens/SocialMedia/YoutubeScreen.dart';
import 'package:memebahadur/utils/StateManagement/loginScreenState.dart';
import 'package:memebahadur/utils/path.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:memebahadur/utils/permissions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
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
    return Consumer(
      builder: (context, watch, child) {
        final user = watch(logincheckProvider).data?.value;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          title: 'MemeBahadur',
          home: SplashScreen(
            seconds: 1,
            navigateAfterSeconds:
                user != null ? NavigationBar() : LoginScreen(),
            image: Image.asset('assets/images/logo.png'),
            photoSize: 200,
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
            '/googletranslate': (BuildContext context) => GoogleTranslate(),
            '/didyoumean': (BuildContext context) => DidYouMean(),
            '/insta': (BuildContext context) => InstaScreen(),
            '/facebook': (BuildContext context) => FacebookPost(),
          },
        );
      },
    );
  }
}
