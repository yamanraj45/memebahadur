import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:memebahadur/widgets/MemeText.dart';
import 'package:memebahadur/utils/permissions.dart';
import 'package:memebahadur/utils/dialogs.dart';
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
  bool imageEdited = false;
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

  _onPressedBack() {
    if (imageEdited) {
      showExitDialog(context);
    } else {
      Navigator.of(context).pushNamed('/home');
    }
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    ImageGallerySaver.saveImage(pngBytes).then((value) => print("Saved"));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightMultiplier = 0.40;
    double width = MediaQuery.of(context).size.width;
    Image _image = widget._imageselected;

    return WillPopScope(
      child: GestureDetector(
        child: Scaffold(
          body: Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: _onPressedBack,
                              ),
                              IconButton(
                                onPressed: () async {
                                  bool status =
                                      await isStoragePermissionGranted();
                                  if (status) {
                                    takeScreenshot();
                                    showSavingDialog(context);
                                  } else {
                                    showFailedDialog(
                                        context, "No storage Permission");
                                    await askStoragePermission();
                                  }
                                },
                                icon: Icon(Icons.save),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 50.00),
                      ),
                      RepaintBoundary(
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
                      Padding(
                        padding: EdgeInsets.only(top: 20.00),
                      ),
                      SizedBox(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Enter Upper Text'),
                          onChanged: (val) {
                            setState(() {
                              upperText = val;
                              imageEdited = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Enter Bottom Text'),
                          onChanged: (val) {
                            setState(() {
                              bottomText = val;
                              imageEdited = true;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.00),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton.icon(
                          padding: EdgeInsets.all(14.00),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blueAccent)),
                          onPressed: () {
                            setState(() {
                              imageEdited = true;
                            });
                            _onAddTextPress(_offset);
                          },
                          label: Text('Add Text'),
                          icon: Icon(Icons.text_fields),
                        ),
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
        ),
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
      ),
      onWillPop: () {
        _onPressedBack();
      },
    );
  }
}
