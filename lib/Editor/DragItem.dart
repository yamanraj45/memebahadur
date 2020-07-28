import 'package:flutter/material.dart';

class DragItem extends StatefulWidget {
  final Offset initPos;
  final Offset widgetOffset;
  final String label;
  final Color color;
  Offset position = Offset(0.0, 0.0);

  DragItem(this.initPos, this.label, this.widgetOffset,
      {this.color = Colors.black});

  @override
  DragItemState createState() => DragItemState();
}

class DragItemState extends State<DragItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: Draggable(
        child: Container(
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: widget.color,
                decoration: TextDecoration.none,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          print(offset);
          setState(() {
            widget.position = offset - widget.widgetOffset;
          });
        },
        maxSimultaneousDrags: 1,
        childWhenDragging: Container(),
        feedback: Container(
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: widget.color,
                decoration: TextDecoration.none,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
