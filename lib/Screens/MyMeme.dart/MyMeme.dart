import 'package:flutter/material.dart';

class MyMeme extends StatefulWidget {
  @override
  _MyMemeState createState() => _MyMemeState();
}

class _MyMemeState extends State<MyMeme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Center(child: Text('MyMemE Section')),
        ),
      ),
    );
  }
}
