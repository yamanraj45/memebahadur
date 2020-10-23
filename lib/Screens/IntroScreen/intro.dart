import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:memebahadur/NavigationBar.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => NavigationBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 15.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    Widget _buildImage() {
      return Align(
        child: Image.asset('assets/images/logo.png', width: 350.0),
        alignment: Alignment.bottomCenter,
      );
    }

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Thanks For Downloading This App.",
          image: _buildImage(),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Create Meme Share Happiness",
          body:
              "Use Build-In Meme Templates From The App Or Use Your Own Template From The Gallery.",
          image: _buildImage(),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Social Media Meme",
          body:
              "Navigate To The Social Media In Boottom Of The Page To Make Meme Of Your Favorite SOcial Media Page",
          image: _buildImage(),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Enjoy The App",
          body: 'Feel Free To Reach Us In Case Of Problem',
          image: _buildImage(),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.blue,
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
