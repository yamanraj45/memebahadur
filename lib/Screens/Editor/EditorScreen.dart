import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:memebahadur/Screens/Editor/EditorDialogs.dart';
import 'package:memebahadur/Screens/Editor/utils.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:memebahadur/widgets/MemeText.dart';
import 'package:memebahadur/widgets/MemeTextInput.dart';
import 'DraggableItem.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

class Editor extends StatefulWidget {
  final Image image;
  Editor(this.image);

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  final GlobalKey previewContainer = new GlobalKey();

  FontOption _upper = FontOption(15, 8, Colors.black);
  FontOption _lower = FontOption(15, 8, Colors.yellow);
  EditorScreenOption _screenOptions = EditorScreenOption();

  _onBackPress() {
    onBackPress(context, flag: _screenOptions.isImageEdited);
  }

  _onSavePress() async {
    setState(() {
      _screenOptions.currentIndex = null;
      _screenOptions.isScrollable = true;
    });
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    // Add a little delay to prevent bounding box from being captured in screenshot
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      onSavePress(context, previewContainer);
    });
  }

  _onSharePress() async {
    setState(() {
      _screenOptions.currentIndex = null;
      _screenOptions.isScrollable = true;
    });
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      takeScreenshot(previewContainer).then((filename) {
        Share.file("MemeBahadur", "memebahadur.jpg",
            File(filename).readAsBytesSync(), "image/jpg");
      });
    });
  }

  void _onFontSizeChange(location, value) {
    value = value;
    setState(() {
      switch (location) {
        case ScreenLocation.uppertext:
          _upper.size = value;
          break;
        case ScreenLocation.lowertext:
          _lower.size = value;
          break;
      }
    });
  }

  void _onFontWeightChange(location, value) {
    setState(() {
      switch (location) {
        case ScreenLocation.uppertext:
          _upper.setWeight(value);
          break;
        case ScreenLocation.lowertext:
          _lower.setWeight(value);
          break;
      }
    });
  }

  void _onColorChange(location, value) {
    setState(() {
      switch (location) {
        case ScreenLocation.uppertext:
          _upper.color = value;
          break;
        case ScreenLocation.lowertext:
          _lower.color = value;
          break;
        case ScreenLocation.backgroundScreenColor:
          _screenOptions.backgroundColor = value;
          break;
        case ScreenLocation.borderScreenColor:
          _screenOptions.borderColor = value;
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _upper.controller.dispose();
    _lower.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Image _image = widget.image;
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                child: ScreenOptionsDialog(
                  options: _screenOptions,
                  onScreenColorChange: _onColorChange,
                ));
          },
          icon: Icon(Icons.edit),
          label: Text('Edit Screen'),
        ),
      ),
      body: GestureDetector(
        child: MemeScaffold(
          isScrollable: _screenOptions.isScrollable,
          onBackPress: _onBackPress,
          onSavePress: _onSavePress,
          onSharePress: _onSharePress,
          child: Builder(
            builder: (context) {
              return Container(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        controller: _upper.controller,
                                        decoration: InputDecoration(
                                            suffixIcon: _upper
                                                    .controller.text.isNotEmpty
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      _upper.controller.clear();
                                                      setState(() {
                                                        _upper.text = '';
                                                      });
                                                    },
                                                  )
                                                : null,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            hintText: 'Enter Upper Text'),
                                        onChanged: (val) {
                                          setState(() {
                                            _upper.text = val;
                                            _screenOptions.isImageEdited = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      child: TextOptionsDialog(
                                        location: ScreenLocation.uppertext,
                                        fontOptions: _upper,
                                        onFontSizeChange: _onFontSizeChange,
                                        onFontWeightChange: _onFontWeightChange,
                                        onFontColorChange: _onColorChange,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.format_size),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                            ),
                          ),
                          child: RepaintBoundary(
                            key: previewContainer,
                            child: Container(
                              color: _screenOptions.backgroundColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: _screenOptions.borderColor,
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    _upper.controller.text.isNotEmpty
                                        ? Container(
                                            color:
                                                _screenOptions.backgroundColor,
                                            child: Text(
                                              _upper.text,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: _upper.color,
                                                  fontSize: _upper.size,
                                                  fontWeight: _upper.weight),
                                            ),
                                          )
                                        : Container(),
                                    Container(
                                      color: _screenOptions.backgroundColor,
                                      height: height * 0.40,
                                      width: width,
                                      alignment: Alignment.bottomCenter,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            child: _image,
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                0 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 0;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 0,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    0,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      0,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                1 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 1;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 1,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    1,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      1,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                2 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 2;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 2,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    2,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      2,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                3 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 3;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 3,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    3,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      3,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                4 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 4;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 4,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    4,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      4,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                5 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 5;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 5,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    5,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      5,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                6 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 6;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 6,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    6,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      6,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                7 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 7;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 7,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    7,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      7,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                8 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 8;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 8,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    8,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      8,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                9 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex = 9;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 9,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    9,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      9,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible:
                                                10 < _screenOptions.latestIndex,
                                            onTap: () {
                                              setState(() {
                                                _screenOptions.currentIndex =
                                                    10;
                                                _screenOptions.isScrollable =
                                                    false;
                                              });
                                            },
                                            index: 10,
                                            isSelected:
                                                _screenOptions.currentIndex ==
                                                    10,
                                            child: MemeTextInput(
                                              isEnabled:
                                                  _screenOptions.currentIndex ==
                                                      10,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: MemeText(
                                                _lower.text,
                                                _lower.size,
                                                _lower.color,
                                                _lower.weightValue),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.00),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _lower.controller,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            _lower.controller.text.isNotEmpty
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      _lower.controller.clear();
                                                      setState(() {
                                                        _lower.text = '';
                                                      });
                                                    },
                                                  )
                                                : null,
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        hintText: 'Enter Bottom Text'),
                                    onChanged: (val) {
                                      setState(() {
                                        _lower.text = val;
                                        _screenOptions.isImageEdited = true;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      child: TextOptionsDialog(
                                        location: ScreenLocation.lowertext,
                                        fontOptions: _lower,
                                        onFontSizeChange: _onFontSizeChange,
                                        onFontWeightChange: _onFontWeightChange,
                                        onFontColorChange: _onColorChange,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.format_size),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.00),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Colors.red[100],
                            child: Row(
                              children: [
                                Icon(Icons.clear),
                                Text("Clear all"),
                              ],
                            ),
                            onPressed: () {
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();
                              setState(() {
                                _screenOptions.latestIndex = 0;
                                _upper.clear();
                                _lower.clear();
                                _screenOptions.currentIndex = null;
                                _screenOptions.isScrollable = true;
                                _screenOptions.isImageEdited = true;
                              });
                            },
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Colors.blue[100],
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text("Add new text"),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _screenOptions.latestIndex++;
                                _screenOptions.currentIndex = null;
                                _screenOptions.isScrollable = true;
                                _screenOptions.isImageEdited = true;
                              });
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.00),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          onBackKeyPress: () {
            _onBackPress();
          },
        ),
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          setState(() {
            _screenOptions.currentIndex = null;
            _screenOptions.isScrollable = true;
          });
        },
      ),
    );
  }
}
