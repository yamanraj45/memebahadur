import 'package:flutter/material.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';

class DidYouMean extends StatefulWidget {
  @override
  _DidYouMeanState createState() => _DidYouMeanState();
}

class _DidYouMeanState extends State<DidYouMean> {
  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                            Text('Logo'),
                            CircleAvatar(
                              backgroundColor: Colors.red,
                            )
                          ],
                        ),
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
