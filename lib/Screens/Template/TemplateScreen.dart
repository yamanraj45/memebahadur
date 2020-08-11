import 'package:flutter/material.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';

import 'TemplateListItem.dart';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  final _templateList = [
    for (int trendImage = 1; trendImage < 6; trendImage++)
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
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Stack(
              children: <Widget>[
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Card(
                      shadowColor: Colors.grey,
                      child: Image.asset('assets/images/logo.png'),
                      elevation: 8.00,
                    ),
                    Card(
                      shadowColor: Colors.grey,
                      child: Image.asset('assets/images/logo.png'),
                      elevation: 8.00,
                    ),
                    Card(
                      shadowColor: Colors.grey,
                      child: Image.asset('assets/images/logo.png'),
                      elevation: 8.00,
                    ),
                    Card(
                      shadowColor: Colors.grey,
                      child: Image.asset('assets/images/logo.png'),
                      elevation: 8.00,
                    ),
                    Card(
                      shadowColor: Colors.grey,
                      child: Image.asset('assets/images/logo.png'),
                      elevation: 8.00,
                    ),
                    Card(
                      shadowColor: Colors.grey,
                      child: Image.asset('assets/images/logo.png'),
                      elevation: 8.00,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(5.00)),
          Expanded(
            child: GridView.builder(
              itemCount: _templateList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
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
                      MaterialPageRoute(builder: (context) => Editor(image)),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
