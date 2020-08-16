import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class MyMemeScreen extends StatefulWidget {
  @override
  _MyMemeScreenState createState() => _MyMemeScreenState();
}

class _MyMemeScreenState extends State<MyMemeScreen> {
  static String path = '/storage/emulated/0/memebahadur/';
  static Directory main = Directory(path);
  static List allItem = main.listSync();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: allItem.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          child: SavedImageListItem(savedImage: allItem[index]),
        );
      },
    );
  }
}

class SavedImageListItem extends StatelessWidget {
  final savedImage;
  SavedImageListItem({this.savedImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(3.00),
        child: savedImage != ''
            ? FittedBox(
                fit: BoxFit.cover,
                child: Image.file(savedImage),
              )
            : Center(
                child: Text(
                  'No Meme Created',
                  style: TextStyle(color: Colors.white),
                ),
              ));
  }
}
