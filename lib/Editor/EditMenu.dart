import 'package:flutter/material.dart';

class EditMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData(iconTheme: IconThemeData(color: Colors.black));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          color: Colors.white12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.format_bold,
                  color: Colors.white70,
                ),
                onPressed: () {},
              ),
              VerticalDivider(),
              IconButton(
                icon: Icon(
                  Icons.format_italic,
                  color: Colors.white70,
                ),
                onPressed: () {},
              ),
              VerticalDivider(),
              IconButton(
                icon: Icon(
                  Icons.format_underlined,
                  color: Colors.white70,
                ),
                onPressed: () {},
              ),
              VerticalDivider(),
              IconButton(
                icon: Icon(
                  Icons.font_download,
                  color: Colors.white70,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text("Undo"),
                        content: Text("Are You Sure You want to undo"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: null,
                          ),
                          FlatButton(
                            child: Text("No"),
                            onPressed: Navigator.of(context).pop,
                          )
                        ],
                      ));
                },
              ),
              VerticalDivider(),
              IconButton(
                icon: Icon(
                  Icons.format_size,
                  color: Colors.white70,
                ),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
      mainAxisSize: MainAxisSize.max,
    );
  }
}

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}
