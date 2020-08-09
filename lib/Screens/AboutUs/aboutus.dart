import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('About Us'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/45logo.png'),
              Text('45developer',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  )),
              Text('nepali45developer@gmail.com',
                  style: TextStyle(
                    fontSize: 15,
                  )),
              Text('Kathmandu Nepal',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ));
  }
}
