import 'Editor.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class FilterList extends StatefulWidget {
  final EditorState e;
  FilterList(this.e);

  @override
  _FilterListState createState() => _FilterListState(this.e);
}

class _FilterListState extends State<FilterList> {
  EditorState e;
  bool showIcon = true;
  _FilterListState(this.e);
  filter(int i) {
    if (i == 1) {
      e.setState(() {
        e.imagefilter = img.brightness(e.imagefilter, 100);
      });
      print(showIcon);
      print(img.brightness(e.imagefilter, 100).getBytes());
      setState(() {
        showIcon = false;
      });
      print(showIcon);
    }
    print(showIcon);
  }

  @override
  Widget build(BuildContext context) {
    print(showIcon);
    return Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(9),
              ),
              IconButton(
                  icon: Icon(Icons.filter_1), //Icon(Icons.filter_1),
                  onPressed: () {
                    filter(1);
                  }),
              Padding(
                padding: EdgeInsets.all(9),
              ),
              IconButton(icon: Icon(Icons.filter_1), onPressed: () {}),
              Padding(
                padding: EdgeInsets.all(9),
              ),
              IconButton(icon: Icon(Icons.filter_1), onPressed: null),
              Padding(
                padding: EdgeInsets.all(9),
              ),
              IconButton(icon: Icon(Icons.filter_1), onPressed: null),
              Padding(
                padding: EdgeInsets.all(9),
              ),
              IconButton(icon: Icon(Icons.filter_1), onPressed: null),
              Padding(
                padding: EdgeInsets.all(9),
              ),
              IconButton(icon: Icon(Icons.filter_1), onPressed: null),
            ],
          )
        ],
      ),
    );
  }
}
