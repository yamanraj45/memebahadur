import 'package:flutter/material.dart';

class SocialMediaHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 30.0, left: 5, right: 5),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SocialMediaNavigatorCard('Youtube',
                          '/youtubescreen', 'assets/images/youtube_logo.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Expanded(
                      child: SocialMediaNavigatorCard('Twitter', '/tweet',
                          'assets/images/twitter_logo.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SocialMediaNavigatorCard('Translate',
                          '/googletranslate', 'assets/images/translate.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Expanded(
                      child: SocialMediaNavigatorCard(
                          'Google', '/didyoumean', 'assets/images/google.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SocialMediaNavigatorCard('Facebook', '/facebook',
                          'assets/images/facebook_logo.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Expanded(
                      child: SocialMediaNavigatorCard('Instagram', '/insta',
                          'assets/images/instagram_logo.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SocialMediaNavigatorCard(
                          'News', '/news', 'assets/images/news.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaNavigatorCard extends StatelessWidget {
  final String _title;
  final String _navigationPath;
  final String _imageLocation;

  SocialMediaNavigatorCard(
      this._title, this._navigationPath, this._imageLocation);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.grey[600],
        elevation: 4,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, _navigationPath),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ListTile(
                title: Center(
                  child: Text(
                    _title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: Image.asset(_imageLocation)),
            ],
          ),
        ),
      ),
    );
  }
}
