import 'dart:io';
import 'package:memebahadur/utils/path.dart';
import 'package:path/path.dart' as paths;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:memebahadur/widgets/MemeText.dart';
import 'package:memebahadur/widgets/MemeTextInput.dart';
import 'DraggableItem.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

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
  String upperText = '';
  bool savedbeforeshare = false;
  List<DraggableItem> texts = [];

  String filed;

  _onBackPress() {
    onBackPress(context, flag: isImageEdited);
  }

  _onSavePress() async {
    setState(() {
      currentIndex = null;
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
    });
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      takeScreenshot(previewContainer).then((filename) {
        Share.file("MemeBahadur", "memebahadur.jpg",
            File(filename).readAsBytesSync(), "image/jpg");
      });
    });
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

    return GestureDetector(
      child: MemeScaffold(
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
                              isImageEdited = true;
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        controller: _uppercontroller,
                        decoration: InputDecoration(
                            suffixIcon: _uppercontroller.text.isNotEmpty
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
                              borderRadius: BorderRadius.circular(50),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                        ),
                        child: RepaintBoundary(
                          key: previewContainer,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  child: Text(
                                    upperText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  height: height * 0.25,
                                  width: width,
                                  alignment: Alignment.bottomCenter,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      // Container(
                                      //   alignment: Alignment.bottomCenter,
                                      //   child: MemeText(bottomText, 20),
                                      // ),
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
                                        child: MemeText(bottomText, 15),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.00),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        child: TextField(
                          controller: _lowercontroller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              suffixIcon: _uppercontroller.text.isNotEmpty
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
                                borderRadius: BorderRadius.circular(50),
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
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.00),
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
        });
      },
    );
  }
}
