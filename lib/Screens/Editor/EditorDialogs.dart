import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:memebahadur/Screens/Editor/utils.dart';

class TextOptionsDialog extends StatefulWidget {
  final ScreenLocation location;
  final fontOptions;
  final Function(ScreenLocation location, double value) onFontSizeChange;
  final Function(ScreenLocation location, double value) onFontWeightChange;
  final Function(ScreenLocation location, Color value) onFontColorChange;

  TextOptionsDialog({
    this.location,
    this.onFontSizeChange,
    this.onFontWeightChange,
    this.onFontColorChange,
    this.fontOptions,
  });

  @override
  _TextOptionsDialogState createState() => _TextOptionsDialogState();
}

class _TextOptionsDialogState extends State<TextOptionsDialog> {
  double _size;
  double _weight;
  Color _color;

  @override
  void initState() {
    super.initState();
    _size = widget.fontOptions.size;
    _weight = widget.fontOptions.weightValue;
    _color = widget.fontOptions.color;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 8.0,
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text('Text Size'),
            Slider(
              label: 'Text Size',
              inactiveColor: Colors.blue,
              min: 10,
              max: 100,
              value: _size,
              onChanged: (value) {
                setState(() {
                  _size = value;
                });
                widget.onFontSizeChange(widget.location, value);
              },
            ),
            Text('Bold'),
            Slider(
              label: 'Bold',
              inactiveColor: Colors.blue,
              min: 1,
              max: 8,
              divisions: 8,
              value: _weight,
              onChanged: (value) {
                setState(() {
                  _weight = value;
                });
                widget.onFontWeightChange(widget.location, value);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Color'),
                SizedBox(
                  width: 30,
                  height: 25,
                  child: FlatButton(
                      child: Text(''),
                      onPressed: () {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text('Pick A Color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _color,
                                onColorChanged: (color) {
                                  setState(() {
                                    _color = color;
                                  });
                                  widget.onFontColorChange(
                                      widget.location, color);
                                },
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Done'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        );
                      },
                      color: _color),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Select'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}

class ScreenOptionsDialog extends StatefulWidget {
  final EditorScreenOption options;
  final Function(ScreenLocation location, Color color) onScreenColorChange;
  ScreenOptionsDialog({this.options, this.onScreenColorChange});

  @override
  _ScreenOptionsDialogState createState() => _ScreenOptionsDialogState();
}

class _ScreenOptionsDialogState extends State<ScreenOptionsDialog> {
  Color _backgroundColor = Colors.white;
  Color _borderColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _backgroundColor = widget.options.backgroundColor;
    _borderColor = widget.options.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Screen"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Background'),
                Container(
                  width: 30,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: _backgroundColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Pick A Color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: _backgroundColor,
                              onColorChanged: (color) {
                                setState(() {
                                  _backgroundColor = color;
                                });
                                widget.onScreenColorChange(
                                    ScreenLocation.backgroundScreenColor,
                                    color);
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Done'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Border'),
                Container(
                  width: 30,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: _borderColor,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Pick A Color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: _borderColor,
                              onColorChanged: (color) {
                                setState(() {
                                  _borderColor = color;
                                });
                                widget.onScreenColorChange(
                                    ScreenLocation.borderScreenColor, color);
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Done'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
