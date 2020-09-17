import 'package:flutter/material.dart';

class SocialMediaHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SocialMediaNavigatorCard('Youtube', '/youtubescreen',
                    'assets/images/youtube_logo.png'),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                SocialMediaNavigatorCard(
                    'Twitter', '/tweet', 'assets/images/twitter_logo.png'),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                SocialMediaNavigatorCard('Google Translator',
                    '/googletranslator', 'assets/images/logo.png'),
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
      height: MediaQuery.of(context).size.height * 0.35,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.grey[600],
        elevation: 4,
        color: Colors.grey[200],
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, _navigationPath),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ListTile(
                title: Center(
                  child: Text(
                    _title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: Image.asset(_imageLocation)),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Center(
              //     child: Text(
              //       'Create a fake Youtube Page that look like a real one',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         color: Colors.black.withOpacity(0.6),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
