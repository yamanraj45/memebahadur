import 'package:flutter/material.dart';
import 'package:image_size_getter/src/core/size.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:hive/hive.dart';
import 'package:memebahadur/utils/constants.dart';
import 'package:memebahadur/utils/image_manager.dart';
import 'dart:io';

class TransitionScreen extends StatelessWidget {
  final Image _image;
  final Size _imageSize;
  TransitionScreen(this._image, this._imageSize);
  addImage(ImageClassSave newEntry) {
    final box = Hive.box(favoriteBox);
    box.add(newEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.red[400],
        width: double.infinity,
        child: FlatButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Editor(_image, _imageSize)),
          ),
          child: Text('Continue'),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: ()async {
                final byte = await ;
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [_image],
        ),
      ),
    );
  }
}
