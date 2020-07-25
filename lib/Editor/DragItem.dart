import 'package:flutter/material.dart';

class DragItem extends StatefulWidget {
  final Offset initPos;
  final Offset widgetOffset;
  final String label;
  final Color itemColor;

  DragItem(this.initPos, this.label, this.itemColor, this.widgetOffset);

  @override
  DragItemState createState() => DragItemState();
}

class DragItemState extends State<DragItem> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        child: Container(
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.red,
                decoration: TextDecoration.none,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          print(offset);
          setState(() {
            position = offset - widget.widgetOffset;
          });
        },
        maxSimultaneousDrags: 1,
        childWhenDragging: Container(),
        feedback: Container(
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.red,
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
