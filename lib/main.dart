import 'package:flutter/material.dart';
import 'package:memebahadur/NavigationBar.dart';
import 'package:memebahadur/Screens/Home/HomeScreen.dart';
import 'package:memebahadur/utils/path.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: NavigationBar(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomeScreen(),
      },
    );
  }
}
