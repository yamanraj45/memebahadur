import 'package:flutter/material.dart';

class TemplateHome extends StatefulWidget {
  @override
  _TemplateHomeState createState() => _TemplateHomeState();
}

class _TemplateHomeState extends State<TemplateHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text('Template'),),
      body: ListView(
        
        children: <Widget>[
          SafeArea(child: 
            SizedBox(
              height: 50.0,
              
              child: Stack(
              children: <Widget>[
                Column(children: <Widget>[


                  Row(children: <Widget>[
                      Text('ASD')
                  ]),
                  Row(
                    children: <Widget>[Text('AD')],
                  )


                ],)
              ],
            ),)
      ,)],),
    );
  }
}