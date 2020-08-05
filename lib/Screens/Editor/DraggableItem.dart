import 'package:flutter/material.dart';

class DraggableItem extends StatefulWidget {
  final Offset initPos;
  final Offset widgetOffset;
  final String label;
  final Color color;
  Offset position = Offset(0.0, 0.0);

  DraggableItem(this.initPos, this.label, this.widgetOffset,
      {this.color = Colors.black});

  @override
  DraggableItemState createState() => DraggableItemState();
}

class DraggableItemState extends State<DraggableItem> {
  String _text = "Add your text here";
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
          // height: 100,
          width: 100,
          // color: Colors.red,
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                hintText: _text,
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                setState(() {
                  _text = text;
                });
              },
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
