import 'dart:io';

import 'package:flutter/material.dart';

class MyMemeScreen extends StatefulWidget {
  @override
  _MyMemeScreenState createState() => _MyMemeScreenState();
}

class _MyMemeScreenState extends State<MyMemeScreen> {
  final dir = Directory('/storage/emulated/0/memebahadur');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () => print(dir),
        ),
      ),
    );
  }
}
