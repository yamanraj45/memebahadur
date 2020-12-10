import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart' as rp;
import 'package:flutter/services.dart';
import 'package:memebahadur/NavigationBar.dart';
import 'package:memebahadur/Screens/AboutUs/aboutus.dart';
import 'package:memebahadur/Screens/Login/loginscreen.dart';
import 'package:memebahadur/Screens/SocialMedia/FacebookScreen.dart';
import 'package:memebahadur/Screens/SocialMedia/GoogleDidYouMean.dart';
import 'package:memebahadur/Screens/SocialMedia/GoogleTranslate.dart';
import 'package:memebahadur/Screens/SocialMedia/InstaScreen.dart';
import 'package:memebahadur/Screens/SocialMedia/NewsScreen.dart';

import 'package:memebahadur/Screens/SocialMedia/TwitterScreen.dart';
import 'package:memebahadur/Screens/SocialMedia/YoutubeScreen.dart';
import 'package:memebahadur/Screens/SplashScreen.dart/splashscreen.dart';

import 'package:memebahadur/utils/StateManagement/loginScreenState.dart';
import 'package:memebahadur/utils/Theme.dart';
import 'package:memebahadur/utils/constants.dart';

import 'package:memebahadur/utils/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:memebahadur/utils/permissions.dart';
import 'package:wiredash/wiredash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.grey[850]),
  );
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Firebase.initializeApp();

  runApp(
    rp.ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final wiredashNavigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    PathUtils.getDataDir();
    askPermissions();
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer(
        builder: (context, ThemeNotifier value, child) {
          return rp.Consumer(
            builder: (context, watch, child) {
              final user = watch(logincheckProvider).data?.value;
              return Wiredash(
                options: WiredashOptionsData(),
                theme: WiredashThemeData(brightness: Brightness.dark),
                navigatorKey: wiredashNavigatorKey,
                projectId: wireProjectId,
                secret: wireDashApi,
                child: MaterialApp(
                  navigatorKey: wiredashNavigatorKey,
                  debugShowCheckedModeBanner: false,
                  theme: value.darkTheme ? dark : light,
                  title: 'Meme Bahadur',
                  home: SplashScreen(),
                  routes: <String, WidgetBuilder>{
                    '/home': (BuildContext context) => NavigationBar(),
                    '/aboutus': (BuildContext context) => AboutUs(),
                    '/tweet': (BuildContext context) => Tweet(),
                    '/youtubescreen': (BuildContext context) => YoutubeScreen(),
                    '/googletranslate': (BuildContext context) =>
                        GoogleTranslate(),
                    '/didyoumean': (BuildContext context) => DidYouMean(),
                    '/insta': (BuildContext context) => InstaScreen(),
                    '/facebook': (BuildContext context) => FacebookPost(),
                    '/news': (BuildContext context) => NewsScreen(),
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//  return Consumer(
//       builder: (context, watch, child) {
//         final user = watch(logincheckProvider).data?.value;
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           darkTheme: ThemeData.dark(),
//           themeMode: ThemeMode.light,
//           title: 'MemeBahadur',
//           home: SplashScreen(
//             seconds: 1,
//             navigateAfterSeconds:
//                 user != null ? NavigationBar() : LoginScreen(),
//             image: Image.asset('assets/images/logo.png'),
//             photoSize: 200,
//             loaderColor: Colors.grey,
//             styleTextUnderTheLoader: TextStyle(
//               backgroundColor: Colors.black,
//               color: Colors.white,
//             ),
//             loadingText: Text(
//               'Getting Things Ready',
//               style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
//             ),
//           ),
//           routes: <String, WidgetBuilder>{
//             '/home': (BuildContext context) => NavigationBar(),
//             '/aboutus': (BuildContext context) => AboutUs(),
//             '/tweet': (BuildContext context) => Tweet(),
//             '/youtubescreen': (BuildContext context) => YoutubeScreen(),
//             '/googletranslate': (BuildContext context) => GoogleTranslate(),
//             '/didyoumean': (BuildContext context) => DidYouMean(),
//             '/insta': (BuildContext context) => InstaScreen(),
//             '/facebook': (BuildContext context) => FacebookPost(),
//             '/news': (BuildContext context) => NewsScreen(),
//           },
//         );
// return ChangeNotifierProvider(
//       create: (_) => ThemeNotifier(),
//       child: Consumer(
//         builder: (context, ThemeNotifier value, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: value.darkTheme ? dark : light,
//             title: 'Meme Bahadur',
//             home: SplashScreen(
//               seconds: 1,
//               navigateAfterSeconds: NavigationBar(),
//               image: Image.asset('assets/images/logo.png'),
//               photoSize: 200,
//               loaderColor: Colors.red,
//               styleTextUnderTheLoader: TextStyle(
//                 backgroundColor: Colors.blue[800],
//                 color: Colors.red,
//               ),
//               loadingText: Text(
//                 'Getting Things Ready',
//                 style:
//                     TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
//               ),
//             ),
//             routes: <String, WidgetBuilder>{
//               '/home': (BuildContext context) => NavigationBar(),
//               '/aboutus': (BuildContext context) => AboutUs(),
//               '/tweet': (BuildContext context) => Tweet(),
//               '/youtubescreen': (BuildContext context) => YoutubeScreen(),
//               '/googletranslate': (BuildContext context) => GoogleTranslate(),
//               '/didyoumean': (BuildContext context) => DidYouMean(),
//               '/insta': (BuildContext context) => InstaScreen(),
//               '/facebook': (BuildContext context) => FacebookPost(),
//               '/news': (BuildContext context) => NewsScreen(),
//             },
//           );
//         },
//       ),
