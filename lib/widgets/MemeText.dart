import 'package:flutter/material.dart';

class MemeText extends StatelessWidget {
  final String _text;
  final double _size;
  MemeText(this._text, this._size);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.w700,
        fontSize: _size,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(-0.5, -0.5),
            blurRadius: 3.0,
            color: Colors.black87,
          ),
          Shadow(
            offset: Offset(0.5, 0.5),
            blurRadius: 8.0,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
