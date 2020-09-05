import 'package:flutter/material.dart';

class MemeTextInput extends StatefulWidget {
  final String text;
  final bool isEnabled;

  MemeTextInput({this.text, @required this.isEnabled});

  @override
  _MemeTextInputState createState() => _MemeTextInputState();
}

class _MemeTextInputState extends State<MemeTextInput> {
  final String defaultText = "Add your text here";
  var shadow = [
    Shadow(
        // bottomLeft
        offset: Offset(-1.5, -1.5),
        color: Colors.black),
    Shadow(
        // bottomRight
        offset: Offset(1.5, -1.5),
        color: Colors.black),
    Shadow(
        // topRight
        offset: Offset(1.5, 1.5),
        color: Colors.black),
    Shadow(
        // topLeft
        offset: Offset(-1.5, 1.5),
        color: Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        enabled: widget.isEnabled,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(
          shadows: shadow,
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: widget.text == null ? defaultText : widget.text,
          hintStyle: TextStyle(
            shadows: shadow,
            fontSize: 20.0,
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
