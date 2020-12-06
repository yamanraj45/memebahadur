import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/utils/Theme.dart';
import 'package:memebahadur/utils/screenshot.dart';
import 'package:memebahadur/widgets/MemeScaffold.dart';
import 'package:provider/provider.dart';

class DidYouMean extends StatefulWidget {
  @override
  DidYouMeanState createState() => DidYouMeanState();
}

class DidYouMeanState extends State<DidYouMean>
    with SingleTickerProviderStateMixin {
  bool _isPageEdited = false;
  bool _isImage = false;
  String didyoumeantext;

  File _avatarImage;
  TextStyle category = TextStyle(fontSize: 12);
  TabController _tabController;

  final picker = ImagePicker();
  final GlobalKey previewContainer = new GlobalKey();
  final TextEditingController _googlesearchtext = TextEditingController();

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _googlesearchtext.dispose();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File path = File(pickedFile.path);
      setState(() {
        _avatarImage = path;
        _isPageEdited = true;
      });
    }
  }

  _onBackPress() {
    onBackPress(context, flag: _isPageEdited);
  }

  _onSavePress() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    onSavePress(context, previewContainer);
  }

  _onSharePress() async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      takeScreenshot(previewContainer).then((filename) {
        Share.file("MemeBahadur", "memebahadur.jpg",
            File(filename).readAsBytesSync(), "image/jpg");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MemeScaffold(
      onBackKeyPress: () {
        _onBackPress();
      },
      onBackPress: _onBackPress,
      onSavePress: _onSavePress,
      onSharePress: _onSharePress,
      child: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RepaintBoundary(
                  key: previewContainer,
                  child: Consumer<ThemeNotifier>(
                    builder: (context, value, child) => Container(
                      color: value.darkTheme ? Colors.grey[850] : Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Icons.menu),
                                      SizedBox(
                                          height: 90,
                                          width: 90,
                                          child: Image.asset(
                                              'assets/images/google.png')),
                                      _isImage
                                          ? GestureDetector(
                                              onTap: () => getImage(),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(70.0),
                                                child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: _avatarImage != null
                                                        ? CircleAvatar(
                                                            radius: 30.0,
                                                            backgroundImage:
                                                                FileImage(
                                                                    _avatarImage),
                                                          )
                                                        : CircleAvatar(
                                                            radius: 30.0,
                                                            backgroundColor:
                                                                Colors.black,
                                                            child:
                                                                Icon(Icons.add),
                                                          )),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.92,
                                        child: Container(
                                          height: 50,
                                          child: TextField(
                                              readOnly: true,
                                              controller: _googlesearchtext,
                                              onChanged: (value) {
                                                setState(() {
                                                  didyoumeantext =
                                                      _googlesearchtext.text;
                                                  _isPageEdited = true;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                fillColor: Colors.grey,
                                                focusColor: Colors.grey,
                                                hoverColor: Colors.grey,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                prefixIcon: Icon(Icons.search),
                                                suffixIcon: _googlesearchtext
                                                        .text.isEmpty
                                                    ? Icon(Icons.mic)
                                                    : IconButton(
                                                        icon: Icon(Icons.close),
                                                        onPressed: () =>
                                                            _googlesearchtext
                                                                .clear(),
                                                      ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TabBar(
                            indicatorColor: Colors.lightBlue[900],
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.lightBlue[900],
                            labelStyle: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                            tabs: [
                              Tab(
                                child: Text(
                                  'ALL',
                                  style: category,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'IMAGES',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'VIDEOS',
                                  style: category,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'BOOKS',
                                  style: category,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'MAPS',
                                  style: category,
                                ),
                              ),
                            ],
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                          SizedBox(
                            height: 80,
                            child: TabBarView(
                              children: [
                                DidYouMeanSection(didyoumeantext),
                                DidYouMeanSection(didyoumeantext),
                                DidYouMeanSection(didyoumeantext),
                                DidYouMeanSection(didyoumeantext),
                                DidYouMeanSection(didyoumeantext),
                              ],
                              controller: _tabController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '   Edit Google Search',
                      style: TextStyle(
                        fontSize: 20.00,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: SwitchListTile(
                        title: Text('Avatar'),
                        value: _isImage,
                        onChanged: (value) {
                          setState(() {
                            _isImage = value;
                            _isPageEdited = true;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: _googlesearchtext,
                        onChanged: (value) {
                          setState(() {
                            _isPageEdited = true;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter The Search Item',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            didyoumeantext = value;
                            _isPageEdited = true;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Enter Did You Mean Text'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DidYouMeanSection extends StatelessWidget {
  final String text;

  DidYouMeanSection(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Consumer<ThemeNotifier>(
                    builder: (context, ThemeNotifier value, child) => RichText(
                      text: TextSpan(
                          text: 'Did You Mean: ',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                value.darkTheme ? Colors.white : Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: text,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.lightBlue[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
