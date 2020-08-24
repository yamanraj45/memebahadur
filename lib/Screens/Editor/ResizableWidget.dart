import 'package:flutter/material.dart';
import 'package:memebahadur/Screens/Editor/ManipulatingBall.dart';

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget({
    @required this.child,
    @required this.index,
    this.isSelected = false,
    this.height = 50,
    this.width = 125,
    this.opacity = 1,
  });
  final Widget child;
  final double height;
  final int index;
  final bool isSelected;
  final double width;
  final double opacity;

  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

class _ResizebleWidgetState extends State<ResizebleWidget> {
  double height;
  double width;
  double top = 100;
  double left = 110;
  double fontScaleX = 1.0;
  double fontScaleY = 1.0;
  @override
  void initState() {
    super.initState();
    height = widget.height;
    width = widget.width;
  }

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 20 ? newHeight : 20;
      width = newWidth > 20 ? newWidth : 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Positioned(
        top: top,
        left: left,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.topCenter,
          child: Transform(
            transform: Matrix4.diagonal3Values(fontScaleX, fontScaleY, 1.0),
            child: widget.child,
          ),
        ),
      )
    ];
    if (widget.isSelected) {
      children = children + _getBorderBalls();
    }
    return Container(
      child: GestureDetector(
        onPanUpdate: (details) {
          var dx = details.delta.dx;
          var dy = details.delta.dy;
          setState(() {
            top = top + dy;
            left = left + dx;
          });
        },
        child: Stack(
          children: children,
        ),
      ),
    );
  }

  List<Widget> _getBorderBalls() {
    return <Widget>[
      // top left
      Positioned(
        top: top - ballDiameter / 2,
        left: left - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var mid = (dx + dy) / 2;
            var newHeight = height - 2 * mid;
            var newWidth = width - 2 * mid;
            setState(() {
              height = newHeight > 20 ? newHeight : 20;
              width = newWidth > 20 ? newWidth : 20;
              top = top + mid;
              left = left + mid;
              fontScaleX = newWidth / 150;
              fontScaleY = newHeight / 50;
            });
          },
        ),
      ),
      // top middle
      Positioned(
        top: top - ballDiameter / 2,
        left: left + width / 2 - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var newHeight = height - dy;
            setState(() {
              height = newHeight > 20 ? newHeight : 20;
              fontScaleY = newHeight / 50.0;
              top = top + dy;
            });
          },
        ),
      ),
      // top right
      Positioned(
        top: top - ballDiameter / 2,
        left: left + width - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var mid = (dx + (dy * -1)) / 2;

            var newHeight = height + 2 * mid;
            var newWidth = width + 2 * mid;

            setState(() {
              height = newHeight > 20 ? newHeight : 20;
              width = newWidth > 20 ? newWidth : 20;
              top = top - mid;
              left = left - mid;
              fontScaleX = newWidth / 150;
              fontScaleY = newHeight / 50;
            });
          },
        ),
      ),
      // center right
      Positioned(
        top: top + height / 2 - ballDiameter / 2,
        left: left + width - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var newWidth = width + dx;

            setState(() {
              width = newWidth > 20 ? newWidth : 20;
              fontScaleX = newWidth / 150;
            });
          },
        ),
      ),
      // bottom right
      Positioned(
        top: top + height - ballDiameter / 2,
        left: left + width - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var mid = (dx + dy) / 2;

            var newHeight = height + 2 * mid;
            var newWidth = width + 2 * mid;

            setState(() {
              height = newHeight > 20 ? newHeight : 20;
              width = newWidth > 20 ? newWidth : 20;
              top = top - mid;
              left = left - mid;
              fontScaleX = newWidth / 150;
              fontScaleY = newHeight / 50;
            });
          },
        ),
      ),
      // bottom center
      Positioned(
        top: top + height - ballDiameter / 2,
        left: left + width / 2 - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var newHeight = height + dy;

            setState(() {
              height = newHeight > 20 ? newHeight : 20;
              fontScaleY = newHeight / 50;
            });
          },
        ),
      ),
      // bottom left
      Positioned(
        top: top + height - ballDiameter / 2,
        left: left - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var mid = ((dx * -1) + dy) / 2;

            var newHeight = height + 2 * mid;
            var newWidth = width + 2 * mid;

            setState(() {
              height = newHeight > 20 ? newHeight : 20;
              width = newWidth > 20 ? newWidth : 20;
              top = top - mid;
              left = left - mid;
              fontScaleX = newWidth / 150;
              fontScaleY = newHeight / 50;
            });
          },
        ),
      ),
      //left center
      Positioned(
        top: top + height / 2 - ballDiameter / 2,
        left: left - ballDiameter / 2,
        child: ManipulatingBall(
          opacity: widget.opacity,
          onDrag: (dx, dy) {
            var newWidth = width - dx;

            setState(() {
              width = newWidth > 20 ? newWidth : 20;
              left = left + dx;
              fontScaleX = newWidth / 150;
            });
          },
        ),
      ),
    ];
  }
}
