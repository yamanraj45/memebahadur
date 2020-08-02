import 'package:flutter/material.dart';

class MemeText extends StatelessWidget {
  final String _text;
  MemeText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.w700,
        fontSize: 26,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 3.0,
            color: Colors.black87,
          ),
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 8.0,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
