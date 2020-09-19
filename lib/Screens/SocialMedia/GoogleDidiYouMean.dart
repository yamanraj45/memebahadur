import 'package:flutter/material.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

class DidYouMean extends StatefulWidget {
  @override
  _DidYouMeanState createState() => _DidYouMeanState();
}

class _DidYouMeanState extends State<DidYouMean> {
  String didyoumeantext = '';
  TextStyle category = TextStyle(color: Colors.grey, fontSize: 12);
  var _googlesearchtext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.menu),
                            Text('Google'),
                            CircleAvatar(
                              backgroundColor: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 50.0,
                                child: TextField(
                                    controller: _googlesearchtext,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey,
                                      focusColor: Colors.grey,
                                      hoverColor: Colors.grey,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      prefixIcon: Icon(Icons.search),
                                      suffixIcon: _googlesearchtext.text.isEmpty
                                          ? Icon(Icons.mic)
                                          : IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () =>
                                                  _googlesearchtext.clear(),
                                            ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'ALL',
                              style: category,
                            ),
                            Text(
                              'IMAGES',
                              style: category,
                            ),
                            Text(
                              'BOOKS',
                              style: category,
                            ),
                            Text(
                              'VIDEOS',
                              style: category,
                            ),
                            Text(
                              'MAP',
                              style: category,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Did You mean: $didyoumeantext',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
