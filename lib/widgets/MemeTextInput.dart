import 'package:flutter/material.dart';

class MemeTextInput extends StatefulWidget {
  final String text;
  final onTap;
  MemeTextInput({@required this.text, this.onTap});

  @override
  _MemeTextInputState createState() => _MemeTextInputState();
}

class _MemeTextInputState extends State<MemeTextInput> {
  final TextEditingController _controller = TextEditingController();
  final String defaultText = "Kaushal Add your text here";
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
        onTap: widget.onTap,
        enableInteractiveSelection: false,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(
          shadows: shadow,
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.text == null ? defaultText : widget.text,
          hintStyle: TextStyle(
            shadows: shadow,
            fontSize: 20.0,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
