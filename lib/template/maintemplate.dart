import 'package:flutter/material.dart';

class TemplateHome extends StatefulWidget {
  @override
  _TemplateHomeState createState() => _TemplateHomeState();
}

class _TemplateHomeState extends State<TemplateHome> {
  int _currentIndex = 0;
  final _templateList = [
    {'name': 'Pashupati Prasad', 'image': 'assets/images/pashupatiprasad.jpg'},
    {'name': 'Hera Pheri', 'image': 'assets/images/herapheri.jpg'},
    {'name': 'Tv Shows', 'image': 'assets/images/tvshows.png'},
    {'name': 'HariBahadur', 'image': 'assets/images/tvshows.png'},
    {'name': 'Real Event', 'image': 'assets/images/tvshows.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Templates'),
      ),
      body: GridView.builder(
        itemCount: _templateList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return TemplateListView(
            templateImage: _templateList[index]['image'],
            templateName: _templateList[index]['name'],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              title: Text('All Template'), icon: Icon(Icons.border_all)),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('Categorry'))
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
    return Card(
        child: Hero(
      tag: templateName,
      child: Material(
        child: InkWell(
          onTap: () {},
          child: GridTile(
            footer: Container(
              color: Colors.grey[100],
              child: ListTile(
                leading: Text(templateName),
              ),
            ),
            child: Image.asset(
              templateImage,
            ),
          ),
        ),
      ),
    ));
  }
}
