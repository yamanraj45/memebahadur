import 'package:flutter/material.dart';

class DidYouMean extends StatefulWidget {
  @override
  DidYouMeanState createState() => DidYouMeanState();
}

class DidYouMeanState extends State<DidYouMean>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  String didyoumeantext;
  TextStyle category = TextStyle(color: Colors.grey, fontSize: 12);
  var _googlesearchtext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.menu),
                          Text('Google'),
                          CircleAvatar(
                            backgroundColor: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 45.0,
                              child: TextField(
                                  controller: _googlesearchtext,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey,
                                    focusColor: Colors.grey,
                                    hoverColor: Colors.grey,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    prefixIcon: Icon(Icons.search),
                                    suffixIcon: _googlesearchtext.text.isEmpty
                                        ? Icon(Icons.mic)
                                        : IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () =>
                                                _googlesearchtext.clear(),
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
                unselectedLabelColor: Colors.black,
                labelColor: Colors.red,
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
                      style: TextStyle(fontSize: 11, color: Colors.grey),
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
              Expanded(
                child: TabBarView(
                  children: [
                    Text('people'),
                    Text('Person'),
                    Text('Person'),
                    Text('Person'),
                    Text('Person'),
                  ],
                  controller: _tabController,
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Did You mean: $didyoumeantext',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
