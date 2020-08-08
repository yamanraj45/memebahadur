import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Center(
                child: Image.asset('assets/images/45logo.png'),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Text('''
            nepali45developers@gmail.com
            Kathmandu, Nepal
            
            ''')
            ],
          ),
        ],
      ),
    );
  }
}
