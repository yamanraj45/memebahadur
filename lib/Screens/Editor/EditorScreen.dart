import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:memebahadur/widgets/MemeText.dart';
import 'package:memebahadur/widgets/MemeTextInput.dart';
import 'DraggableItem.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

enum ScreenLocation {
  uppertext,
  lowertext,
  backgroundScreenColor,
  screenborderColor
}

class Editor extends StatefulWidget {
  final Image _imageselected;
  Editor(this._imageselected);

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  int currentIndex;
  int latestIndex = 0;
  final GlobalKey previewContainer = new GlobalKey();
  bool isImageEdited = false;
  var _uppercontroller = TextEditingController();
  var _lowercontroller = TextEditingController();
  String bottomText = '';
  double _upperFontBold = 5;
  double _lowerFontBold = 8;
  double _upperFontSize = 18;
  double _lowerFontSize = 15;
  String upperText = '';
  bool savedbeforeshare = false;
  List<DraggableItem> texts = [];
  bool isScrollable = true;
  String filed;

  Color pickerColor = Color(0xff443a49);
  Color uppercurrentColor = Color(0xff443a49);
  Color backgroundScreenColor = Color(0xffffffff);
  Color screenBorderColor = Color(0xffffffff);
  Color lowercurrentColor = Color(0xf9ff00ff);
  double _sliderFontValue = 10;
  double _sliderBoldValue = 3;
  _onBackPress() {
    onBackPress(context, flag: isImageEdited);
  }

  _onSavePress() async {
    setState(() {
      currentIndex = null;
      isScrollable = true;
    });
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    // Add a little delay to prevent bounding box from being captured in screenshot
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      onSavePress(context, previewContainer);
    });
  }

  _onSharePress() async {
    setState(() {
      currentIndex = null;
      isScrollable = true;
    });
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      takeScreenshot(previewContainer).then((filename) {
        Share.file("MemeBahadur", "memebahadur.jpg",
            File(filename).readAsBytesSync(), "image/jpg");
      });
    });
  }

  void colorchange(location) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Pick A Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              setState(() {
                pickerColor = color;
              });
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Select'),
            onPressed: () {
              setState(() {
                switch (location) {
                  case ScreenLocation.uppertext:
                    uppercurrentColor = pickerColor;
                    break;
                  case ScreenLocation.lowertext:
                    lowercurrentColor = pickerColor;
                    break;
                  case ScreenLocation.backgroundScreenColor:
                    backgroundScreenColor = pickerColor;
                    break;
                  case ScreenLocation.screenborderColor:
                    screenBorderColor = pickerColor;
                    break;
                }
                Navigator.of(context).pop();
              });
            },
          )
        ],
      ),
    );
  }

  void textSizeChanger(BuildContext context, ScreenLocation location) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    showDialog(
      // barrierDismissible: false,
      context: context,
      child: AlertDialog(
        elevation: 8.0,
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, state) => SizedBox(
              child: Column(
                children: <Widget>[
                  Text('Text Size'),
                  Slider(
                    label: 'Text Size',
                    // activeColor: Colors.red,
                    inactiveColor: Colors.blue,
                    min: 10,
                    max: 100,
                    value: _sliderFontValue,
                    onChanged: (newvalue) {
                      state(() {
                        switch (location) {
                          case ScreenLocation.uppertext:
                            _upperFontSize = _sliderFontValue = newvalue;
                            break;
                          case ScreenLocation.lowertext:
                            _lowerFontSize = _sliderFontValue = newvalue;
                            break;
                          case ScreenLocation.backgroundScreenColor:
                            // ignore: todo
                            // TODO: Handle this case.
                            break;
                          case ScreenLocation.screenborderColor:
                            // ignore: todo
                            // TODO: Handle this case.
                            break;
                        }
                        setState(() {});
                      });
                    },
                  ),
                  Text('Bold'),
                  Slider(
                    label: 'Bold',
                    // activeColor: Colors.red,
                    inactiveColor: Colors.blue,
                    min: 1,
                    max: 8,
                    value: location == ScreenLocation.uppertext
                        ? _upperFontBold
                        : _lowerFontBold,
                    onChanged: (newvalue) {
                      state(() {
                        switch (location) {
                          case ScreenLocation.uppertext:
                            _upperFontBold = _sliderBoldValue = newvalue;
                            break;
                          case ScreenLocation.lowertext:
                            _lowerFontBold = _sliderBoldValue = newvalue;
                            break;

                          case ScreenLocation.backgroundScreenColor:
                            // ignore: todo
                            // TODO: Handle this case.
                            break;
                          case ScreenLocation.screenborderColor:
                            // ignore: todo
                            // TODO: Handle this case.
                            break;
                        }
                        setState(() {});
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('Color Changer'),
                      SizedBox(
                        width: 30,
                        height: 25,
                        child: FlatButton(
                            child: Text(''),
                            onPressed: () => colorchange(location),
                            color: location == ScreenLocation.uppertext
                                ? uppercurrentColor
                                : lowercurrentColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton(onChanged: null)
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Select'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  editScreen() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Edit Screen"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Background'),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.color_lens),
                    onPressed: () =>
                        colorchange(ScreenLocation.backgroundScreenColor),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Border'),
                    ],
                  ),
                  IconButton(
                    onPressed: () =>
                        colorchange(ScreenLocation.screenborderColor),
                    icon: Icon(Icons.color_lens),
                  )
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _uppercontroller.dispose();
    _lowercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;
    Image _image = widget._imageselected;
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton.extended(
          onPressed: () {
            editScreen();
          },
          icon: Icon(Icons.edit),
          label: Text('Edit Screen'),
        ),
      ),
      body: GestureDetector(
        child: MemeScaffold(
          isScrollable: isScrollable,
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
                                        controller: _uppercontroller,
                                        decoration: InputDecoration(
                                            suffixIcon: _uppercontroller
                                                    .text.isNotEmpty
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      _uppercontroller.clear();
                                                      setState(() {
                                                        upperText = '';
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
                                            upperText = val;
                                            isImageEdited = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    textSizeChanger(
                                        context, ScreenLocation.uppertext);
                                  },
                                  icon: Icon(Icons.format_size),
                                ),
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.color_lens,
                                //   ),
                                //   onPressed: () {
                                //     colorchange(ScreenLocation.uppertext);
                                //   },
                                // ),
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
                              color: backgroundScreenColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: screenBorderColor,
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    _uppercontroller.text.isNotEmpty
                                        ? Container(
                                            color: backgroundScreenColor,
                                            child: Text(
                                              upperText,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: uppercurrentColor,
                                                  fontSize: _upperFontSize,
                                                  fontWeight: FontWeight.values[
                                                      _upperFontBold.toInt()]),
                                            ),
                                          )
                                        : Container(),
                                    Container(
                                      color: backgroundScreenColor,
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
                                            isVisible: 0 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 0;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 0,
                                            isSelected: currentIndex == 0,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 0,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 1 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 1;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 1,
                                            isSelected: currentIndex == 1,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 1,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 2 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 2;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 2,
                                            isSelected: currentIndex == 2,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 2,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 3 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 3;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 3,
                                            isSelected: currentIndex == 3,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 3,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 4 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 4;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 4,
                                            isSelected: currentIndex == 4,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 4,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 5 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 5;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 5,
                                            isSelected: currentIndex == 5,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 5,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 6 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 6;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 6,
                                            isSelected: currentIndex == 6,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 6,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 7 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 7;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 7,
                                            isSelected: currentIndex == 7,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 7,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 8 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 8;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 8,
                                            isSelected: currentIndex == 8,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 8,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 9 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 9;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 9,
                                            isSelected: currentIndex == 9,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 9,
                                            ),
                                          ),
                                          DraggableItem(
                                            isVisible: 10 < latestIndex,
                                            onTap: () {
                                              setState(() {
                                                currentIndex = 10;
                                                isScrollable = false;
                                              });
                                            },
                                            index: 10,
                                            isSelected: currentIndex == 10,
                                            child: MemeTextInput(
                                              isEnabled: currentIndex == 10,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: MemeText(
                                                bottomText,
                                                _lowerFontSize,
                                                lowercurrentColor,
                                                _lowerFontBold),
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
                                    controller: _lowercontroller,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            _lowercontroller.text.isNotEmpty
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      _lowercontroller.clear();
                                                      setState(() {
                                                        bottomText = '';
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
                                        bottomText = val;
                                        isImageEdited = true;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    textSizeChanger(
                                        context, ScreenLocation.lowertext);
                                  },
                                  icon: Icon(Icons.format_size),
                                ),
                                // IconButton(
                                //   onPressed: () {
                                //     colorchange(ScreenLocation.lowertext);
                                //   },
                                //   icon: Icon(Icons.color_lens),
                                // ),
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
                                latestIndex = 0;
                                upperText = "";
                                bottomText = "";
                                _uppercontroller.clear();
                                _lowercontroller.clear();
                                currentIndex = null;
                                isScrollable = true;
                                isImageEdited = true;
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
                                latestIndex++;
                                currentIndex = null;
                                isScrollable = true;
                                isImageEdited = true;
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
            currentIndex = null;
            isScrollable = true;
          });
        },
      ),
    );
  }
}
