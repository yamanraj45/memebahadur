import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:memebahadur/widgets/MemeText.dart';
import 'package:path_provider/path_provider.dart';
import 'package:memebahadur/Screens/Editor/EditMenu.dart';
import "package:image/image.dart" as img;
import 'package:permission_handler/permission_handler.dart';
import 'DraggableItem.dart';

class Editor extends StatefulWidget {
  final File _imageselected;
  Editor(this._imageselected);

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  static GlobalKey previewContainer = new GlobalKey();
  String bottomText = '';
  String upperText = '';
  List<DraggableItem> texts = [];

  _onAddTextPress(Offset offset) {
    setState(() {
      texts.add(
        DraggableItem(
          Offset.zero,
          "Add your text here",
          offset,
          color: Colors.red,
        ),
      );
    });
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 5.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    // _askPermission();
    ImageGallerySaver.saveImage(pngBytes)
        .then((value) => print("SAved: $value"));
  }

  showDialogBox(String text) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightMultiplier = 0.40;
    double width = MediaQuery.of(context).size.width;
    File _image = widget._imageselected;

    return Scaffold(
        body: Builder(builder: (context) {
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text("Exit"),
                                  content: Text("Have You Saved Your Meme?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed('/home'),
                                    ),
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: Navigator.of(context).pop,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              takeScreenshot();
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
                                        child: MemeText(bottomText),
                                      ),
                                      Image.file(_image),
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
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Enter Upper Text'),
                      onChanged: (val) {
                        setState(() {
                          upperText = val;
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
                        Offset offset = Offset(8, 88);
                        _onAddTextPress(offset);
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
        }),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: EditMenu(),
        ));
  }
}
