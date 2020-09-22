import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstaScreen extends StatefulWidget {
  @override
  _InstaScreenState createState() => _InstaScreenState();
}

class _InstaScreenState extends State<InstaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                          ),
                        ),
                        new SizedBox(
                          width: 10.0,
                        ),
                        new Text(
                          "imthpk",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    new IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: null,
                    )
                  ],
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: new Image.network(
                    "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.favorite),
                          new SizedBox(
                            width: 16.0,
                          ),
                          new Icon(
                            FontAwesomeIcons.comment,
                          ),
                          new SizedBox(
                            width: 16.0,
                          ),
                          new Icon(FontAwesomeIcons.paperPlane),
                        ],
                      ),
                      new Icon(FontAwesomeIcons.bookmark)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Liked by pawankumar, pk and 528,331 others",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
