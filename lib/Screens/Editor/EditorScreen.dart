import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:memebahadur/widgets/MemeText.dart';
import 'DraggableItem.dart';

class Editor extends StatefulWidget {
  final Image _imageselected;
  Editor(this._imageselected);

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  final GlobalKey previewContainer = new GlobalKey();
  final Offset _offset = Offset(0, 160);
  bool isImageEdited = false;
  String bottomText = '';
  String upperText = '';
  List<DraggableItem> texts = [];

  _onAddTextPress(Offset offset) {
    setState(() {
      texts.add(
        DraggableItem(
          Offset.zero,
          "",
          offset,
          color: Colors.red,
        ),
      );
    });
  }

  _onBackPress() {
    onBackPress(context, flag: isImageEdited);
  }

  _onSavePress() {
    onSavePress(context, previewContainer);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightMultiplier = 0.40;
    double width = MediaQuery.of(context).size.width;
    Image _image = widget._imageselected;

    return GestureDetector(
      child: MemeScaffold(
        onBackPress: _onBackPress,
        onSavePress: _onSavePress,
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                                height: height * heightMultiplier,
                                width: width,
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: MemeText(bottomText),
                                          ),
                                          _image,
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: MemeText(bottomText),
                                          )
                                        ] +
                                        texts),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.00),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: showFab
        //     ? Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           FloatingActionButton(
        //             heroTag: 1,
        //             child: Icon(Icons.photo),
        //             tooltip: 'Add Photo',
        //             onPressed: null,
        //           ),
        //           FloatingActionButton(
        //             onPressed: () {
        //               setState(() {
        //                 isImageEdited = true;
        //               });
        //               _onAddTextPress(_offset);
        //             },
        //             heroTag: 2,
        //             tooltip: 'Add Additional Text',
        //             child: Icon(Icons.text_fields),
        //           )
        //         ],
        //       )
        //     : null,
        onBackKeyPress: () {
          _onBackPress();
        },
      ),
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
    );
  }
}
