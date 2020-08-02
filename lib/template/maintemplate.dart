import 'package:flutter/material.dart';

class TemplateHome extends StatefulWidget {
  @override
  _TemplateHomeState createState() => _TemplateHomeState();
}

class _TemplateHomeState extends State<TemplateHome> {
  final _templateList = [
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('MemeBahadur'),
        centerTitle: true,
      ),
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
                return TemplateListView(
                  templateImage: _templateList[index]['image'],
                  templateName: _templateList[index]['name'],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TemplateListView extends StatelessWidget {
  final templateImage;
  final templateName;

  TemplateListView({this.templateImage, this.templateName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.00),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(templateImage),
      ),
    );
  }
}
