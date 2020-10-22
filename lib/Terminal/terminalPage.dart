import 'package:flutter/material.dart';
import 'package:image_size_getter/src/core/size.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';
import 'package:memebahadur/utils/screenshot.dart';

class TerminalPage extends StatefulWidget {
  final Image image;
  final Size imageSize;

  TerminalPage(this.image, this.imageSize);
  @override
  _TerminalPageState createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  final previewContainer = new GlobalKey();

  _onSavePress() {
    onSavePress(context, previewContainer);
  }

  Widget build(BuildContext context) {
    Icon _favorite = Icon(Icons.favorite_border);
    Size imageSize = widget.imageSize;
    Image image = widget.image;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.star_border,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: IconButton(
                    onPressed: _onSavePress,
                    icon: Icon(
                      Icons.save_alt,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                        child: RepaintBoundary(
                            key: previewContainer, child: image)),
                    Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      bottomSheet: Container(
        height: 50,
        width: double.infinity,
        child: RaisedButton(
          color: Colors.green[800],
          child: Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => {
            print('Clicled'),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Editor(image, imageSize),
              ),
            )
          },
        ),
      ),
    );
  }
}
