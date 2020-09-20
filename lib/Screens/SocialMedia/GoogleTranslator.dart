import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/InputText.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

class GoogleTranslator extends StatefulWidget {
  @override
  _GoogleTranslatorState createState() => _GoogleTranslatorState();
}

class _GoogleTranslatorState extends State<GoogleTranslator> {
  bool _isPageEdited = false;
  String langTranslatedFrom = 'Nepali';
  String langTranslatedTo = 'English';
  String translatedfrom = 'Enter Text';
  String translatedto = '';

  final GlobalKey previewContainer = new GlobalKey();
  var _translatedfrom = TextEditingController();
  var _translatedto = TextEditingController();

  _onBackPress() {
    onBackPress(context, flag: _isPageEdited);
  }

  _onSavePress() {
    onSavePress(context, previewContainer);
  }

  _onSharePress() async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      takeScreenshot(previewContainer).then((filename) {
        Share.file("MemeBahadur", "memebahadur.jpg",
            File(filename).readAsBytesSync(), "image/jpg");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      onBackKeyPress: () {
        _onBackPress();
      },
      onBackPress: _onBackPress,
      onSavePress: _onSavePress,
      onSharePress: _onSharePress,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                RepaintBoundary(
                  key: previewContainer,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        langTranslatedFrom,
                                        style:
                                            TextStyle(color: Colors.blue[600]),
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              child: Icon(Icons.repeat),
                            ),
                            Container(
                              child: Text(
                                langTranslatedTo,
                                style: TextStyle(color: Colors.blue[600]),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  translatedfrom,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                            _translatedto.text.isEmpty
                                ? Container()
                                : Container(
                                    alignment: Alignment.topRight,
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _translatedto.clear();
                                          translatedfrom = 'Enter Text';
                                        });
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  )
                          ],
                        ),
                        _translatedto.text.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.volume_up,
                                        color: Colors.grey[700],
                                        size: 30,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.mic,
                                        color: Colors.grey[700],
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(
                              translatedto,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                        _translatedfrom.text.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.volume_up,
                                        color: Colors.grey[700],
                                        size: 30,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.content_copy,
                                        color: Colors.grey[700],
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: InputText(
                          maxLength: 20,
                          label: 'Translate From',
                          onChanged: (value) {
                            setState(() {
                              langTranslatedFrom = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Container(
                        child: InputText(
                          maxLength: 20,
                          label: 'Translate',
                          onChanged: (value) {
                            setState(() {
                              langTranslatedTo = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Container(
                        child: InputText(
                          maxLength: null,
                          label: 'Text To Translate',
                          controller: _translatedto,
                          onChanged: (value) {
                            setState(() {
                              translatedfrom = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Container(
                        child: InputText(
                          maxLength: null,
                          label: 'Translated Text',
                          controller: _translatedfrom,
                          onChanged: (value) {
                            setState(() {
                              translatedto = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
