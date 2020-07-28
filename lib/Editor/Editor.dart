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
    double heightMultiplier = 0.68;
    double width = MediaQuery.of(context).size.width;
    File _image = widget._imageselected;

    return Scaffold(
        body: SingleChildScrollView(
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
                            onPressed: () {},
                          ),
                          IconButton(
                            onPressed: () {
                              _onSavePress();
                            },
                            icon: Icon(Icons.save),
                          )
                        ],
                      ),
                    )),
                Container(
                  height: height * heightMultiplier,
                  width: width,
                  alignment: Alignment.center,
                  child: Stack(children: <Widget>[Image.file(_image)] + texts),
                ),
                SizedBox(
                  height: 50,
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
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: EditMenu(),
        ));
  }
}
