import 'package:flutter/material.dart';
import 'package:memebahadur/Screens/Editor/EditorScreen.dart';

import 'TemplateListItem.dart';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  final _templateList = [
    for (int extraImage = 1; extraImage < 15; extraImage++)
      {
        'name': 'Extra $extraImage',
        'image': 'assets/images/Extra ($extraImage).jpg'
      },
    for (int realImage = 1; realImage < 15; realImage++)
      {
        'name': 'Real $realImage',
        'image': 'assets/images/Real ($realImage).jpg'
      },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 50.0,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              decoration: new BoxDecoration(
                color: Color(0xFFFCFCFC).withOpacity(0.3),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Search For Templates',
                    border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.00),
          ),
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
                    print("Tapped on ${_templateList[index]['image']}");
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
