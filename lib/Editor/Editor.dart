import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:memebahadur/Editor/EditMenu.dart';
import "package:image/image.dart" as img;
import 'DragItem.dart';

class Editor extends StatefulWidget {
  final File _imageselected;
  Editor(this._imageselected);
  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  String bottomText = '';
  String upperText = '';
  List<DragItem> texts = [];

  _onAddTextPress(Offset offset) {
    setState(() {
      texts.add(
        DragItem(
          Offset.zero,
          "Add your text here",
          offset,
          color: Colors.red,
        ),
      );
    });
  }

  _onSavePress() async {
    // Form image object here
    var image = widget._imageselected;
    var imageBytes = image.readAsBytesSync();
    var decodedImage = img.decodeImage(imageBytes);

    for (var text in texts) {
      var imageText = text.label;
      var offset = text.position;

      // Perform offset calculation if necessary
      // write text to image
      img.drawString(
        decodedImage,
        img.arial_24,
        offset.dx.toInt(),
        offset.dx.toInt(),
        imageText,
      );
      print("Writing $imageText");
    }
    var appDirectory = await getExternalStorageDirectory();
    appDirectory.create(recursive: true);

    print(appDirectory.path);
    File('${appDirectory.path}/myimage.jpg')
        .writeAsBytes(img.encodeJpg(decodedImage))
        .then((value) => showDialogBox("Saved"));

    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
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
                                  ));
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              _onSavePress();
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
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        upperText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                        ),
                      )),
                  Column(children: <Widget>[
                    Container(
                      color: Colors.black,
                      height: height * heightMultiplier,
                      width: width,
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                                Image.file(_image),
                                Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      bottomText.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 26,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 3.0,
                                            color: Colors.black87,
                                          ),
                                          Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 8.0,
                                            color: Colors.black87,
                                          ),
                                        ],
                                      ),
                                    ))
                              ] +
                              texts),
                    ),
                  ]),
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
