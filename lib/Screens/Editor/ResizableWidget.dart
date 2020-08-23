import 'package:flutter/material.dart';
import 'package:memebahadur/Screens/Editor/ManipulatingBall.dart';

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget({
    @required this.child,
    @required this.index,
    this.isSelected = false,
    this.height = 100,
    this.width = 100,
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

  double top = 0;
  double left = 0;
  _ResizebleWidgetState({this.height = 100, this.width = 100});

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
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
          child: widget.child,
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
              height = newHeight > 0 ? newHeight : 0;
              width = newWidth > 0 ? newWidth : 0;
              top = top + mid;
              left = left + mid;
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
              height = newHeight > 0 ? newHeight : 0;
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
              height = newHeight > 0 ? newHeight : 0;
              width = newWidth > 0 ? newWidth : 0;
              top = top - mid;
              left = left - mid;
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
              width = newWidth > 0 ? newWidth : 0;
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
              height = newHeight > 0 ? newHeight : 0;
              width = newWidth > 0 ? newWidth : 0;
              top = top - mid;
              left = left - mid;
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
              height = newHeight > 0 ? newHeight : 0;
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
              height = newHeight > 0 ? newHeight : 0;
              width = newWidth > 0 ? newWidth : 0;
              top = top - mid;
              left = left - mid;
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
              width = newWidth > 0 ? newWidth : 0;
              left = left + dx;
            });
          },
        ),
      ),
    ];
  }
}
