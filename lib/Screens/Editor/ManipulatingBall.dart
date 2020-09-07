import 'package:flutter/material.dart';

final ballDiameter = 20.0;

class ManipulatingBall extends StatelessWidget {
  ManipulatingBall({Key key, this.opacity = 1});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ballDiameter,
      height: ballDiameter,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(this.opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
