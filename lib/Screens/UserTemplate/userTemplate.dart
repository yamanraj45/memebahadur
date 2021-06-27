import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memebahadur/Screens/Template/TemplateListItem.dart';
import 'package:memebahadur/Screens/Template/transitionScreen.dart';
import 'package:memebahadur/utils/Hiveconstant.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserTemplate extends StatefulWidget {
  @override
  _UserTemplateState createState() => _UserTemplateState();
}

class _UserTemplateState extends State<UserTemplate> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(Stared_Template).listenable(),
      builder: (context, box, child) {
        var _templateList = Hive.box(Stared_Template).keys.toList();
        print('*' * 20);
        print(_templateList);
        print('*' * 20);

        return Container(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(5.00)),
              Expanded(
                child: GridView.builder(
                  cacheExtent: 1000,
                  itemCount: _templateList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return InkResponse(
                      child: Image.asset(_templateList[0]),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TemplateTransition(_templateList, index);
                        }));
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
