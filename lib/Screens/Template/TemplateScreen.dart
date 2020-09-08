import 'package:flutter/material.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';

import 'TemplateListItem.dart';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template>
    with AutomaticKeepAliveClientMixin<Template> {
  @override
  bool get wantKeepAlive => true;
  final _templateList = [
    for (int trendImage = 1; trendImage < 9; trendImage++)
      {
        'name': 'Trend $trendImage',
        'image': 'assets/images/1/Trend ($trendImage).jpg'
      },
    for (int pashupatiImage = 1; pashupatiImage < 8; pashupatiImage++)
      {
        'name': 'Pashupati $pashupatiImage',
        'image': 'assets/images/2/Pashupati ($pashupatiImage).jpg'
      },
    for (int haribahadurImage = 1; haribahadurImage < 4; haribahadurImage++)
      {
        'name': 'Haribahadur $haribahadurImage',
        'image': 'assets/images/3/Hari ($haribahadurImage).jpg'
      },
    for (int herapheriImage = 1; herapheriImage < 6; herapheriImage++)
      {
        'name': 'Pashupati $herapheriImage',
        'image': 'assets/images/4/HeraPheri ($herapheriImage).jpg'
      },
    for (int extraImage = 1; extraImage < 92; extraImage++)
      {
        'name': 'Extra $extraImage',
        'image': 'assets/images/5/Extra ($extraImage).jpg'
      },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
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
                    child: TemplateListItem(
                      templateImage: _templateList[index]['image'],
                      templateName: _templateList[index]['name'],
                    ),
                    onTap: () {
                      Image image = Image.asset(_templateList[index]['image']);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => Editor(image),
                          maintainState: true,
                          transitionsBuilder: (c, anim, a2, child) =>
                              SlideTransition(
                                  position: Tween(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset(0.0, 0.0),
                                  ).animate(
                                    CurvedAnimation(
                                        parent: anim, curve: Curves.linear),
                                  ),
                                  child: child),
                          transitionDuration: Duration(milliseconds: 400),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
