import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DraggableItem extends StatefulWidget {
  final Widget child;
  final int index;
  final bool isSelected;
  final Function onTap;
  final bool isVisible;
  DraggableItem(
      {@required this.child,
      @required this.index,
      @required this.onTap,
      this.isVisible = false,
      this.isSelected = true});

  @override
  _DraggableItemState createState() => _DraggableItemState();
}

class _DraggableItemState extends State<DraggableItem> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Container(
        child: GestureDetector(
          onTap: widget.onTap,
          onDoubleTap: widget.onTap,
          onLongPress: widget.onTap,
          child: DraggableItemBase(
            child: widget.child,
            index: widget.index,
            isSelected: widget.isSelected,
          ),
        ),
      ),
    );
  }
}

class DraggableItemBase extends StatefulWidget {
  DraggableItemBase(
      {@required this.child,
      @required this.index,
      this.isSelected = false,
      this.height,
      this.width});

  final Widget child;
  final double height;
  final int index;
  final bool isSelected;
  final double width;

  @override
  _DraggableItemBaseState createState() => _DraggableItemBaseState();
}

class _DraggableItemBaseState extends State<DraggableItemBase> {
  double top = 100;
  double left = 110;
  double scale = 1.0;
  double angle = 0;

  _onScaleIncrease() {
    setState(() {
      scale += 0.1;
    });
  }

  _onScaleDecrease() {
    setState(() {
      scale = scale < 0.6 ? 0.5 : scale - 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Positioned(
        top: top,
        left: left,
        child: Transform.rotate(
          angle: angle,
          child: Transform.scale(
            scale: scale,
            child: GestureDetector(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !widget.isSelected
                        ? SizedBox(height: 30)
                        : Container(
                            // color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                  onTap: _onScaleIncrease,
                                  onDoubleTap: _onScaleIncrease,
                                  child: CircleAvatar(
                                    maxRadius: 15,
                                    child: Icon(Icons.add, size: 15),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 15)),
                                GestureDetector(
                                  onTap: _onScaleDecrease,
                                  onDoubleTap: _onScaleDecrease,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red[300],
                                    maxRadius: 15,
                                    child: Icon(Icons.remove, size: 15),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 15)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      angle -= pi / 10;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green[300],
                                    maxRadius: 15,
                                    child: Icon(Icons.rotate_left, size: 15),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 15)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      angle += pi / 10;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green[300],
                                    maxRadius: 15,
                                    child: Icon(Icons.rotate_right, size: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Container(
                      height: widget.height,
                      width: widget.width == null ? 250 : widget.width,
                      child: DottedBorder(
                        padding: const EdgeInsets.all(0),
                        child: GestureDetector(child: widget.child),
                        strokeWidth: 2,
                        color:
                            widget.isSelected ? Colors.red : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ];
    return GestureDetector(
      onPanUpdate: (details) {
        var dx = details.delta.dx;
        var dy = details.delta.dy;
        setState(() {
          top = top + scale * (dy);
          left = left + scale * (dx);
        });
      },
      child: Container(
        child: Stack(
          children: children,
        ),
      ),
    );
  }
}
