import 'package:flutter/material.dart';

class DraggableItem extends StatefulWidget {
  final Offset initPos;
  final Offset widgetOffset;
  final String label;
  final Color color;
  Offset position = Offset(0.0, 0.0);

  DraggableItem(this.initPos, this.label, this.widgetOffset,
      {this.color = Colors.white});

  @override
  DraggableItemState createState() => DraggableItemState();
}

class DraggableItemState extends State<DraggableItem> {
  final String _text = "Add your text here";
  @override
  void initState() {
    super.initState();
  }

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
  double _scale = 1.0;
  double _previouScale = 1.0;

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: Focus(
        onFocusChange: (value) => {setState(() {})},
        child: Draggable(
          child: Container(
            child: GestureDetector(
              onDoubleTap: () {
                print("tapppp");
              },
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
              child: IntrinsicWidth(
                child: SizedBox(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      shadows: shadow,
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: myController,
                    decoration: InputDecoration(
                      hintText: _text,
                      hintStyle: TextStyle(
                        shadows: shadow,
                        fontSize: 20.0,
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              widget.position = offset - widget.widgetOffset;
            });
          },
          maxSimultaneousDrags: 1,
          childWhenDragging: Container(),
          feedback: Container(
            child: Center(
              child: Text(
                (myController.text == "") ? _text : myController.text,
                style: TextStyle(
                  shadows: shadow,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
