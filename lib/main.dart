import 'package:flutter/material.dart';

import 'package:memebahadur/home_page.dart';
import 'package:memebahadur/template/maintemplate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        '/templates': (BuildContext context) => TemplateHome(),
      },
      home: HomePage(),
    );
  }
}
