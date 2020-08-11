import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class MyMemeScreen extends StatefulWidget {
  @override
  _MyMemeScreenState createState() => _MyMemeScreenState();
}

class _MyMemeScreenState extends State<MyMemeScreen> {
  double _scale = 1.0;
  double _previouScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          _previouScale = _scale;
          print(details);
          setState(() {});
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          _scale = _previouScale * details.scale;
          print(details);
          setState(() {});
        },
        onScaleEnd: (ScaleEndDetails details) {
          _previouScale = 1.0;
          print(details);
          setState(() {});
        },
        child: Center(
            child: Transform(
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child: SizedBox(
                    height: _scale * 2000,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'asdasdasd'),
                    )))));
  }
}
