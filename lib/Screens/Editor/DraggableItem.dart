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
          child: DraggableText(
            child: widget.child,
            index: widget.index,
            isSelected: widget.isSelected,
          ),
        ),
      ),
    );
  }
}

class DraggableText extends StatefulWidget {
  DraggableText(
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
  _DraggableTextState createState() => _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  double top = 100;
  double left = 110;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Positioned(
        top: top,
        left: left,
        child: Container(
          height: widget.height,
          width: widget.width == null ? 250 : widget.width,
          child: DottedBorder(
            padding: const EdgeInsets.all(0),
            child: widget.child,
            strokeWidth: 2,
            color: widget.isSelected ? Colors.red : Colors.transparent,
          ),
        ),
      ),
    ];
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
}
