import 'package:flutter/material.dart';

class MemeScaffold extends StatefulWidget {
  final Widget child;
  final Function onBackPress;
  final Function onSavePress;
  final Function onBackKeyPress;
  MemeScaffold(
      {@required this.child,
      @required this.onBackPress,
      @required this.onSavePress,
      @required this.onBackKeyPress});
  @override
  _MemeScaffoldState createState() => _MemeScaffoldState();
}

class _MemeScaffoldState extends State<MemeScaffold> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onBackKeyPress,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: widget.onBackPress,
          ),
          backgroundColor: Colors.transparent,
          actions: [
            SizedBox(
              height: 80,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: widget.onSavePress,
                      icon: Icon(
                        Icons.save,
                        size: 30,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        body: widget.child,
      ),
    );
  }
}
